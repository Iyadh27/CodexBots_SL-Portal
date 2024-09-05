// TODO Implement this library.// signup_screen.dart
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
      ),
      body: Center(
        child: const Text('This is the Signup Page'),
      ),
    );
  }
}
