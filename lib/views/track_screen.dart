import 'package:flutter/material.dart';

import '../widgets/AudioControlWidget.dart';

class TrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: 'Let it go',
              child: Image.asset(
                'assets/images/meditation_pose.png',
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Find inner harmony and peace...',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              'Pick a voice',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(label: Text('Shekhar'), selected: true),
                SizedBox(width: 8),
                ChoiceChip(label: Text('Amitabh'), selected: false),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Pick a sound track',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(label: Text('Ocean'), selected: true),
                ChoiceChip(label: Text('Wind'), selected: false),
                ChoiceChip(label: Text('Forest'), selected: false),
              ],
            ),
            Spacer(),
            AudioControlWidget(),
          ],
        ),
      ),
    );
  }
}
