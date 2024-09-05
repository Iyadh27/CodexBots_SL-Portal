import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For uploading files

class UploadPage extends StatefulWidget {
  final String title;

  const UploadPage({Key? key, required this.title}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PlatformFile? _selectedFile;
  UploadTask? _uploadTask;

  // Method to select a file from the device
  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    setState(() {
      _selectedFile = result.files.first;
    });
  }

  // Method to upload file to Firebase Storage and return the URL
  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    // Create a Firebase Storage reference
    final storageRef = FirebaseStorage.instance.ref().child('documents/${_selectedFile!.name}');

    // Create an UploadTask and start uploading the file
    setState(() {
      _uploadTask = storageRef.putFile(File(_selectedFile!.path!));
    });

    try {
      // Wait for the upload to complete
      final snapshot = await _uploadTask!.whenComplete(() {});
      
      // Get the file's download URL after the upload
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Pass the URL back to the previous screen
      Navigator.pop(context, downloadUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    } finally {
      setState(() {
        _uploadTask = null;
      });
    }
  }

  // Build the progress indicator for file upload
  Widget buildProgress() {
    if (_uploadTask == null) {
      return const SizedBox(height: 10);
    } else {
      return StreamBuilder<TaskSnapshot>(
        stream: _uploadTask!.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            double progress = snap.bytesTransferred / snap.totalBytes;

            return Column(
              children: [
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 10),
                Text(
                  '${(progress * 100).toStringAsFixed(2)} %',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            );
          } else {
            return const SizedBox(height: 10);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload ${widget.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedFile != null)
              Text('Selected File: ${_selectedFile!.name}'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _selectFile,
              icon: const Icon(Icons.attach_file),
              label: const Text('Select File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _selectedFile != null ? _uploadFile : null,
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
            ),
            const SizedBox(height: 20),
            buildProgress(),
          ],
        ),
      ),
    );
  }
}
