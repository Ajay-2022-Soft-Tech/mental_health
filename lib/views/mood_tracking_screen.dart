import 'package:flutter/material.dart';

class MoodTrackingScreen extends StatefulWidget {
  @override
  _MoodTrackingScreenState createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen>
    with SingleTickerProviderStateMixin {
  String _selectedMood = "";

  void _setMood(String mood) {
    setState(() {
      _selectedMood = mood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange.shade200,
              Colors.deepOrange.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              "How are you feeling today?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _selectedMood.isEmpty ? 1 : 0.5,
              duration: Duration(milliseconds: 300),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildMoodButton("😊", "Happy"),
                  _buildMoodButton("😢", "Sad"),
                  _buildMoodButton("😐", "Neutral"),
                  _buildMoodButton("😤", "Stressed"),
                ],
              ),
            ),
            SizedBox(height: 40),
            AnimatedOpacity(
              opacity: _selectedMood.isNotEmpty ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: Text(
                "You are feeling $_selectedMood",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String mood) {
    return GestureDetector(
      onTap: () => _setMood(mood),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
