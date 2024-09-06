import 'package:flutter/material.dart';
import 'package:sl_portal/3_part_form.dart';

/// Flutter code sample for [TabBar].

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarApp> {
  bool isMultiPartFormComplete = false; // Track if the form is complete
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Callback function when MultiPartForm is complete
  void _onMultiPartFormComplete(bool isComplete) {
    setState(() {
      isMultiPartFormComplete = isComplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: MultiPartForm(onComplete: _onMultiPartFormComplete),
                  ),
                ),
                ElevatedButton(
                  onPressed: isMultiPartFormComplete
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, process the data
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Processing Travel Information'),
                              ),
                            );
                          }
                        }
                      : null, // Disable button if form is not complete
                  child: const Text('Submit'),
                ),
              ],
            ),
            const Center(
              child: Text("It's rainy here"),
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
