import 'package:flutter/material.dart';

class SearchBarComponent extends StatefulWidget {
  final List<Map<String, dynamic>>
      activities; // Accept activities list as a parameter
  final Function(Map<String, dynamic>, bool) onActivitySelected; // Callback

  const SearchBarComponent({
    super.key,
    required this.activities,
    required this.onActivitySelected,
  });

  @override
  State<SearchBarComponent> createState() => _SearchBarComponent();
}

class _SearchBarComponent extends State<SearchBarComponent> {
  late List<Map<String, dynamic>>
      allActivities; // Store the passed activities list
  List<Map<String, dynamic>> filteredActivities =
      []; // Stores filtered activities for search
  List<String> selectedActivities = []; // Stores selected activities
  bool showSearch = true; // To toggle between search and list view
  String searchQuery = '';
  Map<String, dynamic>?
      selectedSearchResult; // Stores the selected search suggestion

  @override
  void initState() {
    super.initState();
    allActivities = widget.activities;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              textStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                (states) => const TextStyle(fontSize: 14.0), // Adjust font size
              ),
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 18.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Close',
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        controller.clear(); // Clear the search bar
                        searchQuery = ''; // Clear search query
                        filterActivities(''); // Reset the list
                        selectedSearchResult = null;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            // Filter activities based on search query
            filterActivities(controller.text);

            // Build suggestion list
            return List<ListTile>.generate(filteredActivities.length,
                (int index) {
              final activity = filteredActivities[index];
              return ListTile(
                title: Text(activity['name']),
                onTap: () {
                  setState(() {
                    selectedSearchResult =
                        activity; // Store selected search result
                    controller.closeView(activity['name']);
                  });
                },
              );
            });
          }),
          const SizedBox(height: 20),
          if (selectedSearchResult != null) // Show when an activity is selected
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: Text(selectedSearchResult!['name'] ??
                        'Unknown'), // Safe access
                    value: selectedSearchResult!['isChecked']
                        as bool?, // Safe casting
                    onChanged: (bool? value) {
                      setState(() {
                        selectedSearchResult!['isChecked'] = value!;
                        widget.onActivitySelected(
                            selectedSearchResult!, value); // Notify parent
                        if (value) {
                          selectedActivities.add(selectedSearchResult!['name']
                              as String); // Safe casting
                        } else {
                          selectedActivities.remove(
                              selectedSearchResult!['name']
                                  as String); // Safe casting
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Filter activities based on the search query
  void filterActivities(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredActivities = allActivities.where((activity) {
          return activity['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  // Renders the list of filtered activities with checkboxes
  ListView renderList() {
    return ListView.builder(
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return CheckboxListTile(
          title: Text(activity['name']), // Display activity name
          value: activity[
              'selected'], // Show checkbox state based on 'selected' field
          onChanged: (bool? value) {
            setState(() {
              activity['selected'] = value!; // Update the selected state
              if (value) {
                selectedActivities
                    .add(activity['name']); // Add to selected list
              } else {
                selectedActivities.remove(activity['name']); // Remove from list
              }
            });
          },
        );
      },
    );
  }
}
