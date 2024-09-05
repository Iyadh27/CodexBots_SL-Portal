import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sl_portal/apllication_detail_page.dart';
// import 'application_details_page.dart'; // To navigate to detailed view page

class ApplicationsListPage extends StatelessWidget {
  const ApplicationsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Visa Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('visa_applications').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching applications'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No applications found'));
          }

          // Extract the list of applications
          var applications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              var appData = applications[index].data() as Map<String, dynamic>;
              var documentId = applications[index].id;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  title: Text(appData['full_name'] ?? 'No Name'),
                  subtitle: Text(appData['passport_number'] ?? 'No Passport Number'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to the details page of this specific application
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationDetailsPage(documentId: documentId),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
