import 'package:flutter/material.dart';

class CourseStepItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final VoidCallback onPlay;

  const CourseStepItemWidget({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.play_circle_fill, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(duration),
        onTap: onPlay,
      ),
    );
  }
}
