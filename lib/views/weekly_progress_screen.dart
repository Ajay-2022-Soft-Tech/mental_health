import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WeeklyProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock data for weekly progress
    final Map<String, Map<String, dynamic>> weeklyData = {
      "steps": {"value": 68503, "goal": 42000, "unit": "Steps"},
      "stressLevel": {"value": "Low", "goal": "Low", "unit": ""},
      "heartRate": {"value": 72, "goal": 75, "unit": "BPM"},
      "distance": {"value": 43.9, "goal": 21.0, "unit": "km"},
      "exerciseTime": {"value": 10.58, "goal": 5.0, "unit": "h"},
      "floors": {"value": 48, "goal": 25, "unit": "Floors"},
      "credits": {"value": 65, "unit": "×"},
    };

    double calculateProgress(dynamic value, dynamic goal) {
      if (value is num && goal is num) {
        return (value / goal).clamp(0.0, 1.0);
      }
      return value == goal ? 1.0 : 0.0;
    }

    String formatTime(double hours) {
      int hr = hours.floor();
      int min = ((hours - hr) * 60).toInt();
      return "${hr}h ${min}m";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weekly Progress",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF7F9FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Text(
                "It’s midweek, and you’ve already achieved remarkable progress!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 20),

              // Weekly Progress List
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildAnimatedProgressItem(
                      icon: Icons.directions_walk,
                      label: "Steps",
                      value:
                      "${weeklyData['steps']!['value']} ${weeklyData['steps']!['unit']}",
                      progress: calculateProgress(
                        weeklyData['steps']!['value'],
                        weeklyData['steps']!['goal'],
                      ),
                      color: Colors.blue,
                    ),
                    _buildAnimatedProgressItem(
                      icon: Icons.self_improvement,
                      label: "Stress Level",
                      value: "${weeklyData['stressLevel']!['value']}",
                      progress: calculateProgress(
                        weeklyData['stressLevel']!['value'],
                        weeklyData['stressLevel']!['goal'],
                      ),
                      color: Colors.purple,
                    ),
                    _buildAnimatedProgressItem(
                      icon: Icons.favorite,
                      label: "Heart Rate",
                      value:
                      "${weeklyData['heartRate']!['value']} ${weeklyData['heartRate']!['unit']}",
                      progress: calculateProgress(
                        weeklyData['heartRate']!['value'],
                        weeklyData['heartRate']!['goal'],
                      ),
                      color: Colors.red,
                    ),
                    _buildAnimatedProgressItem(
                      icon: Icons.directions_run,
                      label: "Distance",
                      value:
                      "${weeklyData['distance']!['value']} ${weeklyData['distance']!['unit']}",
                      progress: calculateProgress(
                        weeklyData['distance']!['value'],
                        weeklyData['distance']!['goal'],
                      ),
                      color: Colors.green,
                    ),
                    _buildAnimatedProgressItem(
                      icon: Icons.timer,
                      label: "Exercise Time",
                      value: formatTime(
                          weeklyData['exerciseTime']!['value'].toDouble()),
                      progress: calculateProgress(
                        weeklyData['exerciseTime']!['value'],
                        weeklyData['exerciseTime']!['goal'],
                      ),
                      color: Colors.orange,
                    ),
                    _buildAnimatedProgressItem(
                      icon: Icons.stairs,
                      label: "Floors",
                      value:
                      "${weeklyData['floors']!['value']} ${weeklyData['floors']!['unit']}",
                      progress: calculateProgress(
                        weeklyData['floors']!['value'],
                        weeklyData['floors']!['goal'],
                      ),
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),

              // Achievement Section
              SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "${weeklyData['credits']!['value']}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Impressive! You've reached your activity goal ${weeklyData['credits']!['value']} times.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for a single animated progress item
  Widget _buildAnimatedProgressItem({
    required IconData icon,
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: progress,
                    backgroundColor: Colors.grey.shade300,
                    progressColor: color,
                    animation: true,
                    animationDuration: 1000,
                    barRadius: Radius.circular(16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(
                color: progress >= 1.0 ? Colors.green : Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
