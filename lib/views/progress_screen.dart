import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Your Progress"),
        backgroundColor: Colors.blueAccent,
      ),
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
                  "Your Progress Report",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
