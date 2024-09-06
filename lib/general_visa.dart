import 'package:flutter/material.dart';

class GeneralVisa extends StatelessWidget {
  final VoidCallback onComplete;

  const GeneralVisa({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Part 1 of the form.'),
            ElevatedButton(
              onPressed: onComplete,
              child: const Text('Complete Part 1'),
            ),
          ],
        ),
      ),
    );
  }
}
