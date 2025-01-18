import 'package:flutter/material.dart';

class MoodTrackingViewModel with ChangeNotifier {
  String _mood = '';

  String get mood => _mood;

  void setMood(String newMood) {
    _mood = newMood;
    notifyListeners();
  }
}
