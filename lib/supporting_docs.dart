// app_form.dart
import 'package:flutter/material.dart';
import 'upload_page.dart'; // Import the upload page

class SupportingDocs extends StatefulWidget {
  final VoidCallback onComplete;

  const SupportingDocs({super.key, required this.onComplete});

  @override
  _SupportingDocsState createState() => _SupportingDocsState();
}

class _SupportingDocsState extends State<SupportingDocs> {
  // Form key to validate form fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to navigate to the upload page with relevant file type
  void _navigateToUploadPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supporting Documents'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildGridItem(context, 'Birth Certificate'),
                  _buildGridItem(context, 'Passport Photo'),
                  _buildGridItem(context, 'Flight Ticket PDF'),
                  _buildGridItem(context, 'Copy of passport detail page'),
                  _buildGridItem(context, 'Proof of Accommodation'),
                  _buildGridItem(context, 'Travel Insurance'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onComplete(); // Navigate to the next step
                  }
                },
                child: const Text('Next'),
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

// Method to build grid item
  Widget _buildGridItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () => _navigateToUploadPage(context, title),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.file_upload,
              size: 40,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
