import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages =
      []; // Store messages as list of maps (user and bot messages)

  // Fetch request to send the message to the backend
  Future<void> sendMessage(String message) async {
    final url = Uri.parse(
        'https://your-backend-api-url.com/chatbot'); // Replace with your backend URL
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final botResponse = jsonDecode(response.body);
        setState(() {
          messages.add({'sender': 'bot', 'text': botResponse['reply']});
        });
      } else {
        setState(() {
          messages.add(
              {'sender': 'bot', 'text': 'Error: Failed to fetch response.'});
        });
      }
    } catch (e) {
      setState(() {
        messages.add(
            {'sender': 'bot', 'text': 'Error: Unable to connect to server.'});
      });
    }
  }

  // Function to handle sending a message
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'sender': 'user', 'text': text});
      });
      _controller.clear();
      sendMessage(text); // Fetch request after sending message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SLP Chat Bot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['sender'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Colors.teal[700] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.teal[700],
                  icon: Icon(Icons.send),
                  onPressed: _handleSend, // Send button triggers message send
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
