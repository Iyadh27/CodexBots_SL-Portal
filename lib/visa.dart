import 'package:flutter/material.dart';
import 'package:sl_portal/3_part_form.dart';

/// Flutter code sample for [TabBar].

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarApp> {
  double _applicationProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _simulateApprovalProgress();
  }

  // Simulates progress update
  void _simulateApprovalProgress() {
    Future.delayed(const Duration(seconds: 3600), () {
      if (_applicationProgress < 1.0) {
        setState(() {
          _applicationProgress += 0.2; // Increment progress by 20% on each step
        });
        _simulateApprovalProgress(); // Continue the progress until 100%
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tourist Visa Application'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Apply",
              ),
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Payment",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const Column(
              children: [
                Expanded(
                  child: MultiPartForm(),
                ),
              ],
            ),
            
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Application Progress",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _applicationProgress,
                    minHeight: 8.0,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${(_applicationProgress * 100).toInt()}% complete",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _applicationProgress == 1.0
                        ? "Your application has been approved!"
                        : "Your application is under review...",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
