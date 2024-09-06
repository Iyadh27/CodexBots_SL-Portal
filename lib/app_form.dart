// app_form.dart
import 'package:flutter/material.dart';
// Import the upload page

class AppForm extends StatefulWidget {
  const AppForm({super.key});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  // Define controllers to manage input fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _travelDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late String _selectedGender = 'Male'; // Variable to hold selected gender

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

  // Form key to validate form fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    // Define a consistent TextStyle for labels and hints
    const TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    );

    return SingleChildScrollView(
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

            // Gender dropdown
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                // border: OutlineInputBorder(),
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

            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
            TextFormField(
              controller: _contactNumberController,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
