import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sl_portal/user_controller.dart'; // Adjust import path as necessary
import 'package:url_launcher/url_launcher.dart';

class UploadPage extends StatefulWidget {
  final String title;
  const UploadPage({super.key, required this.title});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PlatformFile? _selectedFile;
  String? _fileUrl;
  bool _isLoading = false; // Loader flag
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _fetchFileUrl();
  }

  Future<void> _fetchFileUrl() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String userId = _userController.getUserId();
      if (userId.isNotEmpty) {
        // Fetch the document using userId
        QuerySnapshot querySnapshot = await _firestore
            .collection('applications')
            .where('userId', isEqualTo: userId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Document exists, get the file URL
          DocumentSnapshot doc = querySnapshot.docs.first;
          setState(() {
            _fileUrl = doc.get(widget.title + '_Url');
          });
        }
      }
    } catch (e) {
      // Handle fetch error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickFile,
                  child: const Text('Select File'),
                ),
                const SizedBox(height: 20),
                if (_selectedFile != null)
                  Column(
                    children: [
                      Text('Selected File: ${_selectedFile!.name}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _uploadFile,
                        child: const Text('Upload File'),
                      ),
                    ],
                  ),
                if (_fileUrl != null)
                  Column(
                    children: [
                      const Icon(Icons.picture_as_pdf, size: 50),
                      const SizedBox(height: 10),
                      Text('File URL:'),
                      TextButton(
                        onPressed: _downloadFile,
                        child: const Text('Download File'),
                      ),
                    ],
                  ),
                if (_fileUrl == null && _selectedFile == null)
                  const Text(
                    'No file available',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          // Show loader when _isLoading is true
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String userId = _userController.getUserId();
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      // Upload file to Firebase Storage
      Reference ref = _firebaseStorage.ref().child('uploads/${userId}/${_selectedFile!.name}');
      UploadTask uploadTask = ref.putData(_selectedFile!.bytes!);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Get the Firestore document where the userId matches
      QuerySnapshot querySnapshot = await _firestore
          .collection('applications')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, update it
        final documentId = querySnapshot.docs.first.id;
        await _firestore.collection('applications').doc(documentId).update({
          widget.title + '_Url': downloadUrl,
        });
      } else {
        throw Exception('No document found for the given userId');
      }

      setState(() {
        _fileUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Uploaded ${widget.title} successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile() async {
    if (_fileUrl != null) {
      if (await canLaunch(_fileUrl!)) {
        await launch(_fileUrl!);
      } else {
        throw 'Could not launch $_fileUrl';
      }
    }
  }
}
