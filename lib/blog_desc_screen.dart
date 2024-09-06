import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  final String datePosted;
  final String title;
  final String location;
  final double rating;
  final int reviewCount;
  final String description;
  final String imageUrl;

  BlogDetailPage({
    required this.datePosted,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildImage(imageUrl), // Blog main image
            SizedBox(height: 10),
            Text(datePosted, style: TextStyle(color: Colors.grey)),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
            SizedBox(height: 20),

            // Day 01 with Image
            Column(
              children: [
                _buildImage(
                    'https://images.unsplash.com/photo-1606075615798-4dbb278ff9fc?auto=format&fit=crop&w=800&q=80'), // Replace with actual image URL
                SizedBox(height: 10),
                Text(
                  'Day 01\nUpon arrival in Kalpitiya, visitors are greeted by the tranquil beauty of Alankuda Beach. This quiet stretch of coastline provides the perfect setting to unwind after a journey. Accommodations along the beachfront offer direct access to the soft sands and gentle waves, creating an ideal environment for relaxation. The day can be spent leisurely enjoying the beach, with a sunset walk providing a picturesque end to the evening. A seafood dinner at a local restaurant allows guests to savor the fresh flavors of the sea, completing the first day in Kalpitiya.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Day 02 with Image
            Column(
              children: [
                _buildImage(
                    'https://images.unsplash.com/photo-1508317469941-b791fa3e326c?auto=format&fit=crop&w=800&q=80'), // Replace with actual image URL
                SizedBox(height: 10),
                Text(
                  'Day 02\nThe second day begins with an early morning dolphin-watching tour, a must-see experience in Kalpitiya. The waters here are home to large pods of dolphins, and it is common to see them playing and leaping through the waves. After returning to shore, the excitement continues at Kappalady Lagoon, a well-known spot for kite surfing. The lagoon’s steady winds and calm waters make it an ideal location for both beginners and seasoned kite surfers. Alternatively, visitors may choose to explore the nearby mangrove forests by kayak, offering a peaceful and scenic adventure.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Day 03 with Image
            Column(
              children: [
                _buildImage(
                    'https://images.unsplash.com/photo-1552058544-f2b08422138a?auto=format&fit=crop&w=800&q=80'), // Replace with actual image URL
                SizedBox(height: 10),
                Text(
                  'Day 03\nAs Sri Lanka’s largest national park, Wilpattu offers a unique opportunity to observe the country’s diverse wildlife in their natural habitat. Morning safaris are particularly rewarding, with chances to spot leopards, elephants, and various bird species. The park’s natural lakes and lush vegetation add to the allure of this wildlife experience.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      width: double.infinity, // Set the width to take the full screen width
      height: 200, // Adjust the height as needed
      child: Image.network(
        url,
        fit: BoxFit.cover, // Ensures the image covers the container area
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, size: 50, color: Colors.grey),
              Text('Image failed to load', style: TextStyle(color: Colors.red)),
            ],
          );
        },
      ),
    );
  }
}
