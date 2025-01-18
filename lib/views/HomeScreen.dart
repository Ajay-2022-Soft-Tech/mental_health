import 'package:flutter/material.dart';
import 'package:mental_health/views/smart_watch_screen.dart';

// Main Entry Point
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meditation App',
      home: HomeScreen(),
    );
  }
}

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
    ProgressScreen(ratings: {}),
    MeditationPathsScreen(),
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
class MeditationPathsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meditation Paths"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          "Meditation Paths Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
