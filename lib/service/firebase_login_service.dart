import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseLoginService {
  final auth = FirebaseAuth.instance;

  Future<User?> loginFireBaseApi(String email, String password) async {
  try {
    final cred = await auth.signInWithEmailAndPassword(email: email, password: password);
    debugPrint('User: ${cred.user}');
    return cred.user;
  } on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuthException cases
    if (e.code == 'user-not-found') {
      debugPrint('Please enter the valid email address');
    } else if (e.code == 'wrong-password') {
      debugPrint('Please enter the vaild password for the email');
    } else {
      debugPrint('FirebaseAuthException: ${e.message}');
    }
  } catch (e) {
    // Handle other exceptions
    debugPrint('Login Error: $e');
  }
  return null; // Return null if login fails
}
} 