import 'package:flutter/material.dart';
import 'package:sl_portal/3_part_form.dart';

/// Flutter code sample for [TabBar].

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarApp> {
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
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Application')),
                  );
                },
                child: const Text("Show SnackBar"),
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
