import 'package:flutter/material.dart';
import 'package:sl_portal/app_form.dart';

class PersonalVisa extends StatelessWidget {
  final VoidCallback onComplete;

  const PersonalVisa({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppForm(),
            ElevatedButton(
              onPressed: onComplete,
              child: const Text('Next'),
            ),
            const SizedBox(
                height:
                    20), // Adds space between the button and the bottom of the screen
          ],
        ),
      ),
    );
  }
}
