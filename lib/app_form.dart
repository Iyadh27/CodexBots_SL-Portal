import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sl_portal/user_controller.dart'; // Import your UserController

class AppForm extends StatefulWidget {
  const AppForm({super.key});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  // Define controllers to manage input fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passportNumberController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _travelDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late String _selectedGender = 'Male'; // Variable to hold selected gender

  // Variable to manage loading state
  bool _isLoading = false;

  // Date pickers for date fields
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
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

  // Form key to validate form fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find<UserController>();

  // Fetch existing data from Firestore
  Future<void> _fetchFromFirestore() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the user ID from UserController
      String userId = _userController.getUserId();

      // Query to get the document with the specified user ID
      QuerySnapshot querySnapshot = await _firestore
          .collection('applications')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, populate the form fields with the existing data
        final document = querySnapshot.docs.first.data() as Map<String, dynamic>;

        setState(() {
          _fullNameController.text = document['fullName'] ?? '';
          _passportNumberController.text = document['passportNumber'] ?? '';
          _nationalityController.text = document['nationality'] ?? '';
          _dateOfBirthController.text = document['dateOfBirth'] ?? '';
          _travelDateController.text = document['travelDate'] ?? '';
          _returnDateController.text = document['returnDate'] ?? '';
          _contactNumberController.text = document['contactNumber'] ?? '';
          _emailController.text = document['email'] ?? '';
          _selectedGender = document['gender'] ?? 'Male';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Save form data to Firestore
  Future<void> _saveToFirestore() async {
    setState(() {
      _isLoading = true;
    });

    final String userId = _userController.getUserId();

    try {
      // Check if a document with the given userId already exists
      final QuerySnapshot querySnapshot = await _firestore
          .collection('applications')
          .where('userId', isEqualTo: userId)
          .get();

      final Map<String, dynamic> formData = {
        'fullName': _fullNameController.text,
        'passportNumber': _passportNumberController.text,
        'nationality': _nationalityController.text,
        'dateOfBirth': _dateOfBirthController.text,
        'travelDate': _travelDateController.text,
        'returnDate': _returnDateController.text,
        'contactNumber': _contactNumberController.text,
        'email': _emailController.text,
        'gender': _selectedGender,
        'userId': userId,
      };

      if (querySnapshot.docs.isNotEmpty) {
        // Document exists, update it
        final documentId = querySnapshot.docs.first.id;
        await _firestore.collection('applications').doc(documentId).update(formData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application updated successfully!')),
        );
      } else {
        // Document does not exist, create a new one
        await _firestore.collection('applications').add(formData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application saved successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save application: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    // Define a consistent TextStyle for labels and hints
    const TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name (as in passport)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // Gender dropdown
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                  ),
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a gender' : null,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _passportNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Passport Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your passport number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                TextFormField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(
                    labelText: 'Nationality',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your nationality';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                TextFormField(
                  controller: _dateOfBirthController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, _dateOfBirthController),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                TextFormField(
                  controller: _travelDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Planned Travel Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, _travelDateController),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your travel date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _returnDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Return Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, _returnDateController),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your return date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Submit button
                ElevatedButton(
                  onPressed: _saveToFirestore,
                  child: const Text('Submit'),
                ),
              ],
            ),
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
    );
  }
}
