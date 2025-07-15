import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseSignupService {
    final auth = FirebaseAuth.instance;

Future<User?> signUpFireBaseApi(String email, String password) async {
  try {
    final cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return cred.user;
  } on FirebaseAuthException catch (e) {
    // Handle specific FirebaseAuthException cases
    if (e.code == 'email-already-in-use') {
      debugPrint('Error: The email address is already in use by another account.');
    } else if (e.code == 'invalid-email') {
      debugPrint('Error: The email address is not valid.');
    } else if (e.code == 'weak-password') {
      debugPrint('Error: The password is too weak.');
    } else {
      debugPrint('FirebaseAuthException: ${e.message}');
    }
  } catch (e) {
    // Handle other exceptions
    debugPrint('Sign up Error: $e');
  }
  return null; // Return null if sign-up fails
}
}