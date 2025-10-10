import 'package:flutter/material.dart';

class UserAccount {
  final String email;
  UserAccount(this.email);
}

class AuthProvider extends ChangeNotifier {
  final Map<String, String> _users = {}; // email -> password (mock)
  UserAccount? _current;

  UserAccount? get current => _current;
  bool get isAuthenticated => _current != null;

  Future<void> signUp(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_users.containsKey(email)) {
      throw Exception('Email sudah terdaftar');
    }
    _users[email] = password;
    _current = UserAccount(email);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_users[email] != password) {
      throw Exception('Email atau password salah');
    }
    _current = UserAccount(email);
    notifyListeners();
  }

  void signOut() {
    _current = null;
    notifyListeners();
  }
}
