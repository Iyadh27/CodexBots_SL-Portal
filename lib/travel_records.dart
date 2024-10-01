import 'package:flutter/material.dart';

// class TravelHistoryForm extends StatefulWidget {
//   const TravelHistoryForm({super.key});

//   @override
//   _TravelHistoryFormState createState() => _TravelHistoryFormState();
// }

// class _TravelHistoryFormState extends State<TravelHistoryForm> {
//   final List<Map<String, String>> _travelHistory = [];
//   bool _showForm = false;

//   final TextEditingController _countryController = TextEditingController();
//   final TextEditingController _periodController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   void _addTravelHistory() {
//     if (_countryController.text.isNotEmpty &&
//         _periodController.text.isNotEmpty &&
//         _descriptionController.text.isNotEmpty) {
//       setState(() {
//         _travelHistory.add({
//           'Country': _countryController.text,
//           'Period': _periodController.text,
//           'Description': _descriptionController.text
//         });

//         _countryController.clear();
//         _periodController.clear();
//         _descriptionController.clear();
//         _showForm = false;
//       });
//     } else {
//       // Show a snackbar or dialog for empty fields
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//       style: const TextStyle(fontSize: 16.0, color: Colors.black),
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                 height: 300,
//                 child: _travelHistory.isNotEmpty
//                     ? ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: _travelHistory.length,
//                         itemBuilder: (context, index) {
//                           final record = _travelHistory[index];
//                           return Card(
//                             elevation: 5, // Adds shadow and depth
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 8.0,
//                                 horizontal: 16.0), // Spacing around the card
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   15.0), // Rounded corners for the card
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(
//                                   12.0), // Adds padding inside the card
//                               child: ListTile(
//                                 title: Text(
//                                   '${record['Country']} (${record['Period']} days)',
//                                   style: const TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blueAccent,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   record['Description']!,
//                                   style: TextStyle(
//                                     fontSize: 14.0,
//                                     fontStyle: FontStyle.italic,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 leading: const Icon(
//                                   Icons.location_on,
//                                   color: Colors.redAccent,
//                                 ),
//                                 trailing: const Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 16.0,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                     : const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'No travel history added yet',
//                           style: TextStyle(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                 if (_showForm)
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _countryController,
//                           decoration: const InputDecoration(
//                               labelText: 'Country Visited'),
//                         ),
//                         TextFormField(
//                           controller: _periodController,
//                           decoration:
//                               const InputDecoration(labelText: 'Time Period'),
//                         ),
//                         TextFormField(
//                           controller: _descriptionController,
//                           decoration:
//                               const InputDecoration(labelText: 'Description'),
//                           maxLines: 2,
//                         ),
//                         const SizedBox(height: 10),
//                         ElevatedButton(
//                           onPressed: _addTravelHistory,
//                           child: const Text('Add to History'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 16.0,
//             right: 16.0,
//             child: FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   _showForm = !_showForm;
//                 });
//               },
//               child: Icon(_showForm ? Icons.remove : Icons.add),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TravelHistoryRecords extends StatelessWidget {
//   const TravelHistoryRecords({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TravelHistoryForm(); // Integrating TravelHistoryForm
//   }
// }

class TravelHistoryRecords extends StatefulWidget {
  const TravelHistoryRecords({Key? key}) : super(key: key);

  @override
  _TravelHistoryRecordsState createState() => _TravelHistoryRecordsState();
}

class _TravelHistoryRecordsState extends State<TravelHistoryRecords> {
  final List<Map<String, String>> _travelHistory = [];
  bool _showForm = false;

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTravelHistory() {
    if (_countryController.text.isNotEmpty &&
        _periodController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        _travelHistory.add({
          'Country': _countryController.text,
          'Period': _periodController.text,
          'Description': _descriptionController.text
        });

        _countryController.clear();
        _periodController.clear();
        _descriptionController.clear();
        _showForm = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      child: Column(
        children: [
          // Use a SizedBox to constrain ListView's height
          SizedBox(
            height: 200.0, // Adjust this value based on the available space
            child: _travelHistory.isNotEmpty
                ? ListView.builder(
                    itemCount: _travelHistory.length,
                    itemBuilder: (context, index) {
                      final record = _travelHistory[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Text(
                              '${record['Country']} (${record['Period']} days)',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            subtitle: Text(
                              record['Description']!,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No travel history added yet',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
          if (_showForm)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _countryController,
                    decoration:
                        const InputDecoration(labelText: 'Country Visited'),
                  ),
                  TextFormField(
                    controller: _periodController,
                    decoration: const InputDecoration(labelText: 'Time Period'),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addTravelHistory,
                    child: const Text('Add to History'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _showForm = !_showForm;
              });
            },
            child: Icon(_showForm ? Icons.remove : Icons.add),
          ),
        ],
      ),
    );
  }
}
