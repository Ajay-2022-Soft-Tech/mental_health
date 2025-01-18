import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  // Navigation Screens
  final List<Widget> _screens = [
    HomeScreenContent(),
    StressDetectorScreen(),
    ProgressScreen(ratings: {},),
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
                Navigator.pushNamed(context, '/course');
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
            _buildCategoryChips(),
            SizedBox(height: 16),

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

// Placeholder for Stress Detector Screen
class StressDetectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Stress Detector Screen"),
      ),
    );
  }
}

// Placeholder for Progress Screen
class ProgressScreen extends StatelessWidget {
  final Map<int, int> ratings;

  ProgressScreen({required this.ratings});

  String getFeedback(double averageRating) {
    if (averageRating >= 4.0) {
      return "🌟 Excellent! Keep maintaining your healthy habits!";
    } else if (averageRating >= 3.0) {
      return "😊 Good! There's still some room for improvement.";
    } else if (averageRating >= 2.0) {
      return "⚠️ Consider working on improving your habits.";
    } else {
      return "❗ Significant changes or help may be needed.";
    }
  }

  Color getFeedbackColor(double averageRating) {
    if (averageRating >= 4.0) {
      return Colors.greenAccent;
    } else if (averageRating >= 3.0) {
      return Colors.blueAccent;
    } else if (averageRating >= 2.0) {
      return Colors.orangeAccent;
    } else {
      return Colors.redAccent;
    }
  }

  String getRatingDescription(int rating) {
    switch (rating) {
      case 5:
        return "Excellent";
      case 4:
        return "Good";
      case 3:
        return "Average";
      case 2:
        return "Below Average";
      case 1:
      default:
        return "Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    double averageRating =
        ratings.values.reduce((a, b) => a + b) / ratings.values.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF957DAD), Color(0xFFDABFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                Text(
                  "Your Results",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),

                // Summary Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          getFeedbackColor(averageRating),
                          getFeedbackColor(averageRating).withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Average Score: ${averageRating.toStringAsFixed(1)} / 5",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getFeedback(averageRating),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Detailed Ratings
                Expanded(
                  child: ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      final questionIndex = index + 1;
                      final rating = ratings[index] ?? 0;
                      final ratingColor = getFeedbackColor(rating.toDouble());

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: ratingColor.withOpacity(0.2),
                            child: Icon(
                              Icons.star,
                              size: 30,
                              color: ratingColor,
                            ),
                          ),
                          title: Text(
                            "Question $questionIndex",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Rating: $rating (${getRatingDescription(rating)})",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Restart and Go to Home Buttons
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Restart questionnaire
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        "Restart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home'); // Navigate to Home
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        "Go to Home",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
