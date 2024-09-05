// upload_page.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPage extends StatefulWidget {
  final String title;
  const UploadPage({super.key, required this.title});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
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
                    onPressed: () {
                      // Handle file upload logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Uploaded ${widget.title} successfully!')),
                      );
                    },
                    child: const Text('Upload File'),
                  ),
                ],
              ),
            if (_selectedFile == null)
              const Text(
                'No file selected',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
