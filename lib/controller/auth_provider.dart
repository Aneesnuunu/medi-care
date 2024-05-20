import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _onboardingCompleted = false;
  String? _email; // Add email field
  String? _password; // Add password field

  bool get isLoggedIn => _isLoggedIn;
  bool get onboardingCompleted => _onboardingCompleted;
  String? get email => _email; // Getter for email
  String? get password => _password; // Getter for password

  void login(BuildContext context) {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setOnboardingCompleted() {
    _onboardingCompleted = true;
    notifyListeners();
  }

  // Method to set the email
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  // Method to set the password
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
