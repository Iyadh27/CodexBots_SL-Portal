import 'package:flutter/material.dart';
import 'blog_desc_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlogListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum and Blogs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Forum'),
            Tab(text: 'Blogs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Forum Page')),
          BlogsPage(), // Navigate to BlogsPage on clicking Blogs tab
        ],
      ),
    );
  }
}

class BlogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for locations or categories',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),

            // Buttons for sorting options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Most Popular'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Most Recent'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Budget-friendly'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // List of blog articles
            Expanded(
              child: ListView(
                children: [
                  BlogTile(
                    datePosted: '3 months ago',
                    title: 'Exploring Kalpitiya and Beyond: A 4-Day Itinerary',
                    location: 'Kalpitiya',
                    rating: 4.8,
                    reviewCount: 1224,
                    description:
                        'If you\'re looking to experience the beauty of Sri Lanka away from the typical tourist hotspots.',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  BlogTile(
                    datePosted: '2 months ago',
                    title: 'Discovering Ella: The Hill Country\'s Hidden Gem',
                    location: 'Ella',
                    rating: 4.7,
                    reviewCount: 980,
                    description:
                        'Explore the lush landscapes and hidden treasures of Ella, a must-visit for any Sri Lankan itinerary.',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  // Add more BlogTiles here...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String datePosted;
  final String title;
  final String location;
  final double rating;
  final int reviewCount;
  final String description;
  final String imageUrl;
  final TabController? tabController; // Add TabController parameter

  BlogTile({
    required this.datePosted,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.imageUrl,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to BlogDetailPage when tapped and pass the TabController
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailPage(
              title: title,
              datePosted: datePosted,
              location: location,
              rating: rating,
              reviewCount: reviewCount,
              description: description,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Blog image
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              // Blog details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(datePosted, style: TextStyle(color: Colors.grey)),
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        Text(location),
                        Spacer(),
                        Text(
                          '$rating',
                          style: TextStyle(color: Colors.amber),
                        ),
                        Text(' ($reviewCount reviews)'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
