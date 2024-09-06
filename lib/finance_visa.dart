import 'package:flutter/material.dart';
import 'package:sl_portal/finance_form.dart';

class FinanceVisa extends StatelessWidget {
  final VoidCallback onComplete;

  const FinanceVisa({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FinanceFormApp(),
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
