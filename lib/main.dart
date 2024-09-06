import 'package:flutter/material.dart';
import 'pages/discover.dart';
import 'pages/profile.dart';
import 'pages/saved.dart';
import 'pages/socials.dart';

import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x007A8F)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // You can navigate to different pages based on index here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _getPage(index)),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const MyHomePage(title: 'Home');
      case 1:
        return const SocialsPage();
      case 2:
        return const MapPage();
      case 3:
        return const SavedPlacesPage();
      case 4:
        return const ProfilePage();
      default:
        return const MyHomePage(title: 'Home');
    }
  }

  final List<String> featuredCars = ['Car 1', 'Car 2', 'Car 3'];
  final List<String> newArrivals = ['Car 4', 'Car 5', 'Car 6'];
  final List<String> bestSellers = ['Car 7', 'Car 8', 'Car 9'];
  void funsearchController() {
    print("pressed");
    return;
  }

  final TextEditingController _searchController = TextEditingController();
  Widget buildCarouselSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 28.0),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor, // Primary color as background
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0), // Rounded top-right corner
                  bottomRight:
                      Radius.circular(20.0), // Rounded bottom-right corner
                ),
              ),
              child: Text(
                title,

                style: TextStyle(
                  color: Colors.white, // Text color for contrast
                  fontSize: 18,
                ),
                textAlign: TextAlign.left, // Left aligned text
              ),
            )),
        CarouselSlider(
          options: CarouselOptions(
              height: 200.0,
              viewportFraction: 0.5,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      ' $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildCarouselSection('Popular Destinations', featuredCars),
                buildCarouselSection('To Do Activites', newArrivals),
                buildCarouselSection('Saved Places', bestSellers),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PopupMenuButton<int>(
          onSelected: (value) {
            // Handle navigation based on selected item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _getPage(value)),
            );
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Icon(Icons.home)),
            PopupMenuItem<int>(value: 1, child: Icon(Icons.social_distance)),
            PopupMenuItem<int>(value: 2, child: Icon(Icons.map)),
            PopupMenuItem<int>(value: 3, child: Icon(Icons.file_copy)),
            PopupMenuItem<int>(value: 4, child: Icon(Icons.man)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.social_distance), label: "Social"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
        ],
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text('Home Page')));
//   }
// }

// class SocialPage extends StatelessWidget {
//   const SocialPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Socials')),
//         body: Center(child: Text('Social Page')));
//   }
// }

// // class MapPage extends StatelessWidget {
// //   const MapPage({super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(title: const Text('Discover')),
// //         body: Center(child: Text('Map Page')));
// //   }
// // }

// class PlacesPage extends StatelessWidget {
//   const PlacesPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Saved places')),
//         body: Center(child: Text('Saved')));
//   }
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('User Profile')),
//         body: Center(child: Text('Profile Page')));
//   }
// }
