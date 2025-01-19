import 'package:flutter/material.dart';
import 'package:mental_health/views/smart_watch_screen.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/views/weekly_progress_screen.dart';


// Home Screen with Bottom Navigation Bar
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Navigation Screens
  final List<Widget> _screens = [
    HomeScreenContent(),
    SmartwatchScreen(),
    WeeklyProgressScreen(),
    ChatBotScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300), // Smooth transition
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Meditation'),
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: 'Watch'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Chat'),
        ],
      ),
    );
  }
}

// HomeScreenContent Widget
class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DeepBreathe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
              radius: 20,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            Text(
              'Good Morning, Rahul',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // Top Meditation Program Section
            Text(
              'Top meditation program for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Add your functionality here
              },
              child: _buildMeditationCard(
                title: "Let it go",
                subtitle: "Don't Judge Yourself",
                duration: "32 min",
                description: "6 tracks · 2 min read",
                imagePath: 'assets/images/sloth.png',
              ),
            ),
            SizedBox(height: 24),

            // Meditation Paths Section
            Text(
              'Meditation paths for you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // Category Chips
            _buildCategoryChips(),

            // Meditation Cards
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final cardDetails = [
                    {
                      "title": "What is meditation",
                      "subtitle": "From conflict to harmony step 1",
                      "duration": "10 min",
                      "description": "4 tracks · 1 min read",
                      "imagePath": "assets/images/meditation.png",
                    },
                    {
                      "title": "Learn to sit",
                      "subtitle": "Discover the art of stillness step 1",
                      "duration": "14 min",
                      "description": "4 tracks · 2 min read",
                      "imagePath": "assets/images/sit.png",
                    }
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildMeditationCard(
                      title: cardDetails[index]['title']!,
                      subtitle: cardDetails[index]['subtitle']!,
                      duration: cardDetails[index]['duration']!,
                      description: cardDetails[index]['description']!,
                      imagePath: cardDetails[index]['imagePath']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Meditation Card Widget
  Widget _buildMeditationCard({
    required String title,
    required String subtitle,
    required String duration,
    required String description,
    required String imagePath,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover, // Ensures the image covers the entire container
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        // Overlay to make text readable
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer, color: Colors.white70, size: 16),
                  SizedBox(width: 4),
                  Text(
                    duration,
                    style: TextStyle(color: Colors.white70),
                  ),
                  Spacer(),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Category Chips
  Widget _buildCategoryChips() {
    final categories = ['Recommended', 'Breathe', 'Calm', 'Music'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map(
              (category) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text(
                category,
                style: TextStyle(
                  color: category == 'Recommended'
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: category == 'Recommended'
                  ? Colors.blueAccent
                  : Colors.grey.shade200,
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

// Smartwatch Screen Placeholder

// Progress Screen Placeholder
class ProgressScreen extends StatelessWidget {
  final Map<int, int> ratings;

  ProgressScreen({required this.ratings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Progress Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Meditation Paths Screen


class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  bool _isTyping = false;

  final String _apiKey = ""; // Replace with your OpenAI API Key


  // Function to send a message
  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = _messageController.text.trim();

      setState(() {
        _messages.add({
          'sender': 'user',
          'message': userMessage,
        });
        _isTyping = true;
      });

      _messageController.clear();

      // Call OpenAI API to get the chatbot's response
      final botResponse = await _getBotResponse(userMessage);

      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': botResponse,
        });
        _isTyping = false;
      });
    }
  }

  // Function to get bot response from OpenAI API
  Future<String> _getBotResponse(String userMessage) async {
    const String apiUrl = "https://api.openai.com/v1/chat/completions";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": userMessage},
          ],
          "max_tokens": 100,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return "Sorry, I couldn't process your request. Please try again later.";
      }
    } catch (e) {
      print("Error: $e");
      return "An error occurred. Please check your internet connection.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'ChatBot',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 5,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF2F3F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Chat Messages
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - index - 1];
                  final isUser = message['sender'] == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.blueAccent.withOpacity(0.9)
                            : Colors.white,
                        gradient: isUser
                            ? LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: isUser ? Radius.circular(12) : Radius.zero,
                          bottomRight: isUser ? Radius.zero : Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Typing Indicator
            if (_isTyping) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircularProgressIndicator(strokeWidth: 2, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text(
                      "Assistant is typing...",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],

            // Message Input
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
