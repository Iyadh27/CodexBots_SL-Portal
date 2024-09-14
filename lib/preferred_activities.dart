import 'package:flutter/material.dart';
import 'package:sl_portal/bucket_list.dart';
import 'package:sl_portal/search_bar.dart';

class PreferredActivities extends StatefulWidget {
  const PreferredActivities({super.key});

  @override
  State<PreferredActivities> createState() => _PreferredActivitiesState();
}

class _PreferredActivitiesState extends State<PreferredActivities> {
  // List of activities
  final List<Map<String, dynamic>> activities = [
    {'name': 'Cycling', 'isChecked': false},
    {'name': 'Sailing', 'isChecked': false},
    {'name': 'Boat Safaris', 'isChecked': false},
    {'name': 'Hiking', 'isChecked': false},
    {'name': 'Kayaking', 'isChecked': false},
    // Add more activities here (up to 20 or more)
    {'name': 'Fishing', 'isChecked': false},
    {'name': 'Rock Climbing', 'isChecked': false},
    {'name': 'Surfing', 'isChecked': false},
    {'name': 'Scuba Diving', 'isChecked': false},
    {'name': 'Zip-lining', 'isChecked': false},
    {'name': 'Camping', 'isChecked': false},
    {'name': 'Bungee Jumping', 'isChecked': false},
    {'name': 'Paragliding', 'isChecked': false},
    {'name': 'Snowboarding', 'isChecked': false},
    {'name': 'Skiing', 'isChecked': false},
    {'name': 'Horse Riding', 'isChecked': false},
    {'name': 'Mountain Biking', 'isChecked': false},
    {'name': 'Skydiving', 'isChecked': false},
    {'name': 'Water Skiing', 'isChecked': false},
    {'name': 'Caving', 'isChecked': false},
  ];

  // List to store the selected activities
  List<String> selectedActivities = [];

  // Function to update selected activities list
  void _updateSelectedActivities(
      Map<String, dynamic> activity, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedActivities.add(activity['name']);
      } else {
        selectedActivities.remove(activity['name']);
      }
      // Print the selected activities list to the console
      print('Selected Activities: $selectedActivities');
    });
  }

  // Function to navigate to the AppForm screen
  void _navigateToBucketList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BucketList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Preferred Activities')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SearchBarComponent(
                activities: activities,
                onActivitySelected: _updateSelectedActivities),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 1.0, // Space between columns
                    mainAxisSpacing: 1.0, // Space between rows
                    childAspectRatio: 4 / 1, // Aspect ratio (width / height)
                  ),
                  itemCount: activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final activity = activities[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: activity['isChecked']
                            ? const Color.fromARGB(
                                255, 160, 205, 212) // Prime color when checked
                            : const Color.fromARGB(255, 211, 220, 221),
                        borderRadius:
                            BorderRadius.circular(25), // Radius of the corners
                      ), // Gray color when not checked
                      margin: const EdgeInsets.all(4),
                      child: CheckboxListTile(
                        value: activity['isChecked'],
                        onChanged: (bool? value) {
                          // Check if the user has selected 5 or more activities
                          if (value == true && selectedActivities.length >= 5) {
                            // Show a message when the limit is reached
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'You can only select up to 5 activities.'),
                              ),
                            );
                          } else {
                            setState(() {
                              activity['isChecked'] = value!;
                              _updateSelectedActivities(activity, value);
                            });
                          }
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(activity['name'],
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                      ),
                    );
                  }),
            ),
            const Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToBucketList(
                    context); // Navigate to AppForm when clicked
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
