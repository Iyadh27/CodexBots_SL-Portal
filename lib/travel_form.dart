import 'package:flutter/material.dart';

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
