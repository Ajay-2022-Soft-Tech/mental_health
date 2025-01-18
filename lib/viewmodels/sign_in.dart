import 'package:flutter/material.dart';

class SignInViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    // Add Google Sign-In Logic here
    await Future.delayed(Duration(seconds: 2)); // Simulate API call
    _isLoading = false;
    notifyListeners();
  }

  void signInWithMicrosoft() async {
    _isLoading = true;
    notifyListeners();

    // Add Microsoft Sign-In Logic here
    await Future.delayed(Duration(seconds: 2)); // Simulate API call
    _isLoading = false;
    notifyListeners();
  }
}
