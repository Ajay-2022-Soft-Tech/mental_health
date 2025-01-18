import 'package:flutter/material.dart';

class HydrationScreen extends StatefulWidget {
  @override
  _HydrationScreenState createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen>
    with SingleTickerProviderStateMixin {
  int _waterIntake = 0;

  void _addGlass() {
    setState(() {
      _waterIntake++;
    });
  }

  void _resetIntake() {
    setState(() {
      _waterIntake = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade400,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              "Hydration Tracker",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.blue.shade700,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "${_waterIntake} / 8 glasses",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _addGlass,
                  child: AnimatedScale(
                    scale: 1,
                    duration: Duration(milliseconds: 300),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.add, color: Colors.blue, size: 30),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _resetIntake,
                  child: AnimatedScale(
                    scale: 1,
                    duration: Duration(milliseconds: 300),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.refresh, color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
