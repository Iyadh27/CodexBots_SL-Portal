import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

class ApplicationDetailsPage extends StatelessWidget {
  final String documentId;

  const ApplicationDetailsPage({Key? key, required this.documentId}) : super(key: key);

  // Method to open URLs
  Future<void> _openURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('visa_applications').doc(documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading application details'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Application not found'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full Name: ${data['full_name'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Passport Number: ${data['passport_number'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Nationality: ${data['nationality'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Date of Birth: ${data['date_of_birth'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Travel Date: ${data['travel_date'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Return Date: ${data['return_date'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Contact Number: ${data['contact_number'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Email: ${data['email'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),

                // Document URLs
                const Text('Uploaded Documents:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildDocumentLink('Birth Certificate', data['birth_certificate_url']),
                const SizedBox(height: 10),
                _buildDocumentLink('Passport Photo', data['passport_photo_url']),
                const SizedBox(height: 10),
                _buildDocumentLink('Flight Ticket', data['flight_ticket_url']),
                const SizedBox(height: 10),
                _buildDocumentLink('Bank Statement', data['bank_statement_url']),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to create clickable document links
  Widget _buildDocumentLink(String label, String? url) {
    if (url == null || url.isEmpty) {
      return Text('$label: Not Uploaded', style: const TextStyle(fontSize: 16, color: Colors.red));
    }
    return GestureDetector(
      onTap: () => _openURL(url),
      child: Text('$label: View Document', style: const TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline)),
    );
  }
}
