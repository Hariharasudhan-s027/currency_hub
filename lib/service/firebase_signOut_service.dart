import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseSignoutService {
   final auth = FirebaseAuth.instance;

  Future<void> signOutFireBaseApi() async {
    try {
    await auth.signOut();
    } catch (e) {
      debugPrint('sign out Error: $e');
    }
  }
}