import 'package:flutter/material.dart';
import 'package:sl_portal/singup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'pages/discover.dart';
import 'pages/profile.dart';
import 'pages/saved.dart';
import 'pages/socials.dart';
import 'slpchat/chatbot.dart';
import 'package:carousel_slider/carousel_slider.dart';
void main()  async {


await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );// Initialize Firebase 

    Get.put(UserController()); // Initializes the UserController globally

runApp(const SignupScreen());
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

    print(_selectedIndex);
    // You can navigate to different pages based on index here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _getPage(index)),
    );
  }

    void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }
  //  @override
  // void initState() {
  //   super.initState();
  //   // Navigate to the Signup screen automatically when the page loads
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _navigateToSignup();
  //   });
  // }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const MyHomePage(title: 'Home');
      case 1:
        return const SocialsPage();
      case 2:
        return MapPage();
      case 3:
        return const SavedPlacesPage();
      case 4:
        return const ProfilePage();
      case 5:
        return ChatBotScreen();
      default:
        return const MyHomePage(title: 'Home');
    }
  }

  List<List<String>> features = [
    ['Visa', 'Now visa processing at your fingertips', 'assets/visa.jpg'],
    ['SLP bot', 'Your native companion', 'assets/chat.jpg'],
  ];
  List<List<String>> featuredCars = [
    ['Lotus Tower', 'Colombo', 'assets/lotus.jpg'],
    ['Mirissa', 'Galle', 'assets/mirissa.jpg'],
    ['Kandy', 'Kandy', 'assets/kandy.jpg']
  ];
  List<List<String>> newArrivals = [
    ['Elephant Watching', 'Pinnawala', 'assets/elephant.jpg'],
    ['Hiking', 'Nuwara Eliya', 'assets/hiking.jpg'],
    ['Surfing', 'Hikkaduwa', 'assets/hikkaduwa.jpg']
  ];
  List<List<String>> bestSellers = [
    ['Nine Arch Bridge', 'Ella', 'assets/ninearch.jpg'],
    ['Dunhinda Ella', 'Badulla', 'assets/dunhida.jpg'],
    ['Mirissa', 'Galle', 'assets/mirissa.jpg']
  ];

  void funsearchController() {
    print("pressed");
    return;
  }

  final TextEditingController _searchController = TextEditingController();
  Widget buildCarouselSection2(List<List<String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 150.0,
              viewportFraction: 0.5,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image:
                                AssetImage(i[2]), // Update with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black
                                  .withOpacity(0.6), // Adjust opacity as needed
                              Colors.black
                                  .withOpacity(0.0), // Adjust opacity as needed
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Content with text
                      Padding(
                        padding: const EdgeInsets.all(
                            16.0), // Add padding to make space for text
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              i[0],
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    8.0), // Add space between title and description
                            Text(
                              i[1],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }

  Widget buildCarouselSection(String title, List<List<String>> items) {
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
              height: 230.0,
              viewportFraction: 0.5,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              padEnds: false),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(i[2]), // Your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(
                                  0.6), // Adjust opacity for the gradient
                              Colors.black.withOpacity(0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Content with text
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Align content to the bottom
                          children: [
                            Text(
                              i[0], // Title
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              i[1], // Location
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            // Star Rating
                            Row(
                              children: List.generate(
                                5, // Star count
                                (index) => Icon(
                                  index < 3 // assuming i[3] holds the rating (out of 5)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Details button in the bottom-right corner
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: TextButton(
                          onPressed: () {
                            // Define what happens when 'Details' is pressed
                          },
                          child: Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black
                                .withOpacity(0.5), // Button background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 28.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor, // Primary color as background
                    borderRadius: BorderRadius.only(
                      topRight:
                          Radius.circular(20.0), // Rounded top-right corner
                      bottomRight:
                          Radius.circular(20.0), // Rounded bottom-right corner
                    ),
                  ),
                  child: Text(
                    "Welcome Gina",

                    style: TextStyle(
                      color: Colors.white, // Text color for contrast
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left, // Left aligned text
                  ),
                ),
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
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(child: buildCarouselSection2(features)),
                buildCarouselSection('Popular Destinations', featuredCars),
                buildCarouselSection('To Do Activites', newArrivals),
                buildCarouselSection('Saved Places', bestSellers),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: PopupMenuButton<int>(
          iconColor: Theme.of(context).primaryColor,
          onSelected: (value) {
            // Handle navigation based on selected item
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _getPage(value)),
            );
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 3, child: Icon(Icons.file_copy)),
            PopupMenuItem<int>(value: 4, child: Icon(Icons.man)),
            PopupMenuItem<int>(value: 5, child: Icon(Icons.chat)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
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
