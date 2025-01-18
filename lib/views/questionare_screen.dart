import 'package:flutter/material.dart';
import 'dart:async';

class HackathonQuestionnaireScreen extends StatefulWidget {
  @override
  _HackathonQuestionnaireScreenState createState() =>
      _HackathonQuestionnaireScreenState();
}

class _HackathonQuestionnaireScreenState
    extends State<HackathonQuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Map<int, int> _ratings = {}; // Store ratings for each question (1-5)

  final List<Question> _questions = [
    Question(
      title: "Heart Rate Analysis",
      description:
      "Do you experience irregular heart rates or feel anxious frequently?",
      image: "assets/images/heart_rate.png",
      gradientColors: [Color(0xFFE0BBE4), Color(0xFF957DAD)],
    ),
    Question(
      title: "Sleep Cycle",
      description:
      "How would you describe your sleep pattern? Do you get 7-8 hours of sleep regularly?",
      image: "assets/images/sleep_cycle.png",
      gradientColors: [Color(0xFFDABFFF), Color(0xFF9F87D1)],
    ),
    Question(
      title: "Stress Levels",
      description:
      "How often do you feel stressed or overwhelmed in your daily life?",
      image: "assets/images/stress_analysis.png",
      gradientColors: [Color(0xFFCDB4DB), Color(0xFFB39CD0)],
    ),
    Question(
      title: "Mental Status",
      description:
      "How would you rate your overall mental well-being in the past week?",
      image: "assets/images/mental_status.png",
      gradientColors: [Color(0xFFEACCFB), Color(0xFFD9BBF9)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _questions.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the progress screen after the last question
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalysisProgressScreen(
            ratings: _ratings,
          ),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _questions[_currentPage].gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / _questions.length,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  question.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              question.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              question.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 30),
                            _buildRatingRow(index),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _currentPage == 0 ? null : _previousPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(width: 8),
                            Text("Previous"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _ratings.containsKey(_currentPage)
                            ? _nextPage
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Row(
                          children: [
                            Text(
                                _currentPage == _questions.length - 1
                                    ? "Finish"
                                    : "Next"),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(int questionIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (rating) {
        final isSelected = _ratings[questionIndex] == (rating + 1);
        return IconButton(
          onPressed: () {
            setState(() {
              _ratings[questionIndex] = rating + 1; // Store rating
            });
          },
          icon: Icon(
            Icons.star,
            size: 36,
            color: isSelected ? Colors.yellow : Colors.white30,
          ),
        );
      }),
    );
  }
}

class Question {
  final String title;
  final String description;
  final String image;
  final List<Color> gradientColors;

  Question({
    required this.title,
    required this.description,
    required this.image,
    required this.gradientColors,
  });
}

class AnalysisProgressScreen extends StatefulWidget {
  final Map<int, int> ratings;

  AnalysisProgressScreen({required this.ratings});

  @override
  _AnalysisProgressScreenState createState() =>
      _AnalysisProgressScreenState();
}

class _AnalysisProgressScreenState extends State<AnalysisProgressScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  void _startAnalysis() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progress >= 1.0) {
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                ratings: widget.ratings,
              ),
            ),
          );
        } else {
          _progress += 0.05;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Analyzing your responses...",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              value: _progress,
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
            SizedBox(height: 20),
            Text(
              "${(_progress * 100).toInt()}% Complete",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final Map<int, int> ratings;

  ResultsScreen({required this.ratings});

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
