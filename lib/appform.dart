import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(VisaApplicationFormApp());
}

class VisaApplicationFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisaApplicationForm(),
    );
  }
}

class VisaApplicationForm extends StatefulWidget {
  @override
  _VisaApplicationFormState createState() => _VisaApplicationFormState();
}

class _VisaApplicationFormState extends State<VisaApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _selectedFile;

  // Function to pick a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedFile != null) {
      // Process the form data
      print('Name: ${_nameController.text}');
      print('Passport Number: ${_passportController.text}');
      print('Email: ${_emailController.text}');
      print('File Path: ${_selectedFile!.path}');
      
      // Display a success message or proceed with your desired action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submitted Successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and upload a file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visa Application Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passportController,
                decoration: InputDecoration(
                  labelText: 'Passport Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passport number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.attach_file),
                label: Text(_selectedFile == null
                    ? 'Upload File'
                    : 'File Selected: ${_selectedFile!.path.split('/').last}'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
