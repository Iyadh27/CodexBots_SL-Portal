import 'package:flutter/material.dart';

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
        return const HomePage();
      case 1:
        return const SocialPage();
      case 2:
        return const MapPage();
      case 3:
        return const PlacesPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Text(
          'You have pushed the button this many times:',
        ),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Page')));
  }
}

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Social Page')));
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Map Page')));
  }
}

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Places Page')));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Profile Page')));
  }
}
