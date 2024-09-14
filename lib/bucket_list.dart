import 'package:flutter/material.dart';
import 'package:sl_portal/itenerary.dart';

class BucketList extends StatefulWidget {
  const BucketList({super.key});

  @override
  State<BucketList> createState() => _BucketListState();
}

class _BucketListState extends State<BucketList> {
  // List of Places
  final List<Map<String, dynamic>> places = [
    {'name': 'Sigiriya Rock Fortress', 'isChecked': false},
    {'name': 'Yala National Park Safari', 'isChecked': false},
    {'name': 'Ella Rock Hike', 'isChecked': false},
    {'name': 'Kandy Temple of the Tooth', 'isChecked': false},
    {'name': 'Galle Fort', 'isChecked': false},
    {'name': 'Nuwara Eliya Tea Plantations', 'isChecked': false},
    {'name': 'Mirissa Whale Watching', 'isChecked': false},
    {'name': 'Horton Plains National Park', 'isChecked': false},
    {'name': 'Anuradhapura Ancient Ruins', 'isChecked': false},
    {'name': 'Polonnaruwa Ancient City', 'isChecked': false},
    {'name': 'Dambulla Cave Temple', 'isChecked': false},
    {'name': 'Bentota Beach', 'isChecked': false},
    {'name': 'Unawatuna Beach', 'isChecked': false},
    {'name': 'Arugam Bay Surfing', 'isChecked': false},
    {'name': 'Galle Face Green', 'isChecked': false},
    {'name': 'Colombo City Tour', 'isChecked': false},
    {'name': 'Jaffna Cultural Experience', 'isChecked': false},
    {'name': 'Negombo Fishing Village', 'isChecked': false},
    {'name': 'Kalpitiya Kite Surfing', 'isChecked': false},
    {'name': 'Dambulla Golden Temple', 'isChecked': false},
  ];

  // List to store the selected activities
  List<String> selectedPlaces = [];

  // Function to update selected Places_updateSelectedPlaces list
  void _updateSelectedPlaces(String activity, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedPlaces.add(activity);
      } else {
        selectedPlaces.remove(activity);
      }
      // Print the selected Places_updateSelectedPlaces list to the console
      print('Selected Places_updateSelectedPlaces: $selectedPlaces');
    });
  }

  // Function to navigate to the AppForm screen
  void _navigateToItenerary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Itenerary()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Bucket List Places')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 1.0, // Space between columns
                    mainAxisSpacing: 1.0, // Space between rows
                    childAspectRatio: 4 / 1, // Aspect ratio (width / height)
                  ),
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {
                    final activity = places[index];
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
                          // Check if the user has selected 5 or more Places_updateSelectedPlaces
                          if (value == true && selectedPlaces.length >= 5) {
                            // Show a message when the limit is reached
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('You can only select up to 5 places.'),
                              ),
                            );
                          } else {
                            setState(() {
                              activity['isChecked'] = value!;
                              _updateSelectedPlaces(activity['name'], value);
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
                _navigateToItenerary(
                    context); // Navigate to Itenerary when clicked
              },
              child: const Text('Build Itenerary'),
            ),
          ],
        ),
      ),
    );
  }
}
