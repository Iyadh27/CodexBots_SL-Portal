// main.dart
import 'package:flutter/material.dart';
import 'app_form.dart'; // Import the AppForm screen

void main() {
  runApp(const SignupScreen());
}

// class SignupScreen extends StatelessWidget {
//   const SignupScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
      
//       home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Login & Signup'),
            
//             bottom: const TabBar(
//               tabs: [
//                 Tab(text: 'Login'),
//                 Tab(text: 'Signup'),
//               ],
//             ),
//              // Remove shadow from AppBar
//           ),
//           body: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/login view.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
            
//             child: const Column(
//             children: [
//               Spacer(),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     LoginCard(),
//                     SignupCard(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login & Signup'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Signup'),
              ],
              labelColor: Color(0xFF007A8F), // Color of the selected tab text
              unselectedLabelColor: Colors.grey, // Color of the unselected tab text
              indicatorColor: Colors.black, // Color of the indicator (underline)
              indicatorWeight: 4.0, // Thickness of the indicator (underline)
            ),
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow from AppBar
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login view.png'), // Ensure the path is correct
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),
            child: const Column(
              children: [
                Spacer(),
                Expanded(
                  child: TabBarView(
                    children: [
                      LoginCard(),
                      SignupCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  // Function to navigate to the AppForm screen
  void _navigateToAppForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AppForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  _navigateToAppForm(context); // Navigate to AppForm when clicked
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007A8F), // Background color of the button
                  foregroundColor: Colors.white, // Text color
                  
                ),  
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupCard extends StatelessWidget {
  const SignupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle signup logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007A8F), // Background color of the button
                  foregroundColor: Colors.white, // Text color
                ),
                child: const Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
