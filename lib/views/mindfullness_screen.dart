import 'package:flutter/material.dart';

class MindfulnessScreen extends StatelessWidget {
  final List<String> mindfulnessTracks = [
    "Ocean Sounds",
    "Rainy Day",
    "Forest Ambience",
    "Calm Music",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade200,
              Colors.green.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              "Mindfulness Exercises",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mindfulnessTracks.length,
                itemBuilder: (context, index) {
                  final track = mindfulnessTracks[index];
                  return _buildAnimatedTrackItem(context, track, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTrackItem(BuildContext context, String track, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/track', arguments: track);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(Icons.headphones, color: Colors.green),
            title: Text(
              track,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
