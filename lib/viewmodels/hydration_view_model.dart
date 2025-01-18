import 'package:flutter/material.dart';

class HydrationViewModel with ChangeNotifier {
  int _waterIntake = 0;

  int get waterIntake => _waterIntake;

  void addGlass() {
    _waterIntake++;
    notifyListeners();
  }

  void resetIntake() {
    _waterIntake = 0;
    notifyListeners();
  }
}
