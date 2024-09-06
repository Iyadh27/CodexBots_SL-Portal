import 'package:flutter/material.dart';
import 'package:sl_portal/upload_page.dart';

class FinanceFormApp extends StatelessWidget {
  const FinanceFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Information Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FinanceForm(),
    );
  }
}

class FinanceForm extends StatefulWidget {
  const FinanceForm({super.key});

  @override
  _FinanceFormState createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  final _formKey = GlobalKey<FormState>();

  // Financial Information controllers
  final _fundsController = TextEditingController();
  final _employmentController = TextEditingController();
  final _sponsorController = TextEditingController();
  final _workAddressController = TextEditingController();
  final _occupationController = TextEditingController();
  final _employerController = TextEditingController();

  void _navigateToUploadPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadPage(title: title),
      ),
    );
  }

  // Form submission handler
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proceed with form submission (e.g., send data, go to the next page, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Purpose of Visit

            const Divider(), // Financial Information Section Divider

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1, // Adjust to show only one column
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio:
                  3 / 2, // This can be adjusted based on your preference
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildGridItem(context, 'Bank Account Statements'),
              ],
            ),

            const SizedBox(height: 25),

            TextFormField(
              controller: _occupationController,
              decoration: const InputDecoration(
                labelText: 'Occupation',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your occupation';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Employer
            TextFormField(
              controller: _employerController,
              decoration: const InputDecoration(
                labelText: 'Employer',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your employer\'s name';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Work Address
            TextFormField(
              controller: _workAddressController,
              decoration: const InputDecoration(
                labelText: 'Work Address',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your work address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Sponsorship Details (if applicable)
            TextFormField(
              controller: _sponsorController,
              decoration: const InputDecoration(
                  labelText: 'Sponsorship Details (if applicable)'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Finance Information'),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fundsController.dispose();
    _employmentController.dispose();
    _sponsorController.dispose();
    super.dispose();
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
