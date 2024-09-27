import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  final List<String> tags = [
    "Nature",
    "Sightseeing",
    "Adventure",
    "Hill Country",
    "Culture",
    "Budget",
    "Food",
    "Skyline"
  ];

  final List<Map<String, dynamic>> forumAnswers = [
    {
      "topic": "Best places to visit in Sri Lanka",
      "tags": ["Nature", "Hill Country"],
      "description":
          "The hill country offers breathtaking views and peaceful surroundings."
    },
    {
      "topic": "Top budget-friendly destinations",
      "tags": ["Budget", "Food"],
      "description":
          "You can find amazing local cuisine at affordable prices in these locations."
    },
    {
      "topic": "Exploring cultural landmarks",
      "tags": ["Culture", "Sightseeing"],
      "description":
          "Discover historical landmarks that showcase the rich heritage of the region."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Solid outlined box for "Post Your Question"
              GestureDetector(
                onTap: () {
                  // Handle post question action
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Post Your Question',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Topic: Search by Location
              Text(
                'Search By Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Search Box
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Country, City or Town',
                ),
              ),
              SizedBox(height: 20),

              // Topic: Choose Tags
              Text(
                'Choose Tags:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Horizontal list of tags
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: tags.map((tag) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        label: Text(tag),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Forum Answers List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: forumAnswers.map((answer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Topic
                          Text(
                            answer["topic"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),

                          // Tags
                          Wrap(
                            spacing: 8.0,
                            children: answer["tags"].map<Widget>((tag) {
                              return Chip(label: Text(tag));
                            }).toList(),
                          ),
                          SizedBox(height: 8),

                          // Description
                          Text(answer["description"]),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
