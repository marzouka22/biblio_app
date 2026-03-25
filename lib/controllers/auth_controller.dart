import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/member_model.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();

  Member? _currentMember;
  bool _isLoading = false;
  bool _isFirebaseAvailable = false;

  Member? get currentMember => _currentMember;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentMember != null;
  bool get isAdmin => _currentMember?.role == UserRole.admin;

  // Initialize checks auth state
  Future<void> initialize() async {
    try {
      _authService.authStateChanges.listen((User? user) async {
        _isFirebaseAvailable = true;
        if (user != null) {
          _isLoading = true;
          notifyListeners();
          _currentMember = await _authService.getMemberDetails(user.uid);
          _isLoading = false;
          notifyListeners();
        } else {
          _currentMember = null;
          notifyListeners();
        }
      });
    } catch (e) {
      print("AuthController initialization failed (Firebase unavailable): $e");
      _isFirebaseAvailable = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    if (!_isFirebaseAvailable) {
      print("Mock Mode: Simulating sign in for $email");
      await Future.delayed(const Duration(seconds: 1));
      _currentMember = Member(
        id: 'mock_user_id',
        email: email,
        firstName: 'Mock',
        lastName: 'User',
        role: UserRole.member,
      );
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await _authService.signIn(email, password);
      // Listener will handle update
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    _isLoading = true;
    notifyListeners();

    if (!_isFirebaseAvailable) {
      print("Mock Mode: Simulating sign up for $email");
      await Future.delayed(const Duration(seconds: 1));
      _currentMember = Member(
        id: 'mock_user_id',
        email: email,
        firstName: firstName,
        lastName: lastName,
        role: UserRole.member,
      );
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await _authService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      // Listener will handle update
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (!_isFirebaseAvailable) {
      print("Mock Mode: Simulating sign out");
      _currentMember = null;
      notifyListeners();
      return;
    }
    await _authService.signOut();
    _currentMember = null;
    notifyListeners();
  }
}
