import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sl_portal/user_controller.dart'; // Import your UserController

class TravelFormApp extends StatelessWidget {
  const TravelFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Information Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TravelForm(),
    );
  }
}

class TravelForm extends StatefulWidget {
  const TravelForm({super.key});

  @override
  _TravelFormState createState() => _TravelFormState();
}

class _TravelFormState extends State<TravelForm> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers to store form inputs
  final _purposeController = TextEditingController();
  final _dateController = TextEditingController();
  final _durationController = TextEditingController();
  final _accommodationController = TextEditingController();
  final _itineraryController = TextEditingController();
  final _historyController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final UserController _userController = Get.find<UserController>();

  // Date pickers for date fields
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _fetchFromFirestore() async {
    try {
      // Get the user ID from UserController
      String userId = _userController.getUserId(); // Replace this with actual user ID fetching logic

      // Query to get the document with the specified user ID
      QuerySnapshot querySnapshot = await _firestore
          .collection('travelForms')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, populate the form fields with the existing data
        final document = querySnapshot.docs.first.data() as Map<String, dynamic>;

        setState(() {
          _purposeController.text = document['purpose'] ?? '';
          _dateController.text = document['date'] ?? '';
          _durationController.text = document['duration'] ?? '';
          _accommodationController.text = document['accommodation'] ?? '';
          _itineraryController.text = document['itinerary'] ?? '';
          _historyController.text = document['history'] ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    }
  }
Future<void> _saveToFirestore() async {
  final String userId = _userController.getUserId();

  // Collect data from form fields
  final Map<String, dynamic> formData = {
    'purpose': _purposeController.text,
    'date': _dateController.text,
    'duration': _durationController.text,
    'accommodation': _accommodationController.text,
    'itinerary': _itineraryController.text,
    'history': _historyController.text,
    'userId': userId,
  };

  try {
    // Check if a document with the given userId already exists
    final QuerySnapshot querySnapshot = await _firestore
        .collection('travelForms')
        .where('userId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Document exists, update it
      final documentId = querySnapshot.docs.first.id;
      await _firestore.collection('travelForms').doc(documentId).update(formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Travel form updated successfully!')),
      );
    } else {
      // Document does not exist, create a new one
      await _firestore.collection('travelForms').add(formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Travel form save successfully!')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit form: $e')),
    );
  }
}


  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first built
    _fetchFromFirestore();
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
            TextFormField(
              controller: _purposeController,
              decoration: const InputDecoration(labelText: 'Purpose of Visit'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the purpose of your visit';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Intended Date of Travel
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Intended Date of Travel',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, _dateController),
                ),
              ),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the date of travel';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Duration of Stay
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                  labelText: 'Duration of Stay (in days)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the duration of your stay';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Accommodation Details
            TextFormField(
              controller: _accommodationController,
              decoration: const InputDecoration(
                  labelText: 'Accommodation Details (Address of hotel)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter accommodation details';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),

            // Previous Travel History
            TextFormField(
              controller: _historyController,
              decoration:
                  const InputDecoration(labelText: 'Previous Travel History'),
              maxLines: 3,
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveToFirestore();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _purposeController.dispose();
    _dateController.dispose();
    _durationController.dispose();
    _accommodationController.dispose();
    _itineraryController.dispose();
    _historyController.dispose();
    super.dispose();
  }
}
