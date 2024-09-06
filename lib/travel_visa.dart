import 'package:flutter/material.dart';
import 'package:sl_portal/travel_form.dart';

class TravelVisa extends StatelessWidget {
  final VoidCallback onComplete;

  const TravelVisa({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TravelFormApp(),
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
