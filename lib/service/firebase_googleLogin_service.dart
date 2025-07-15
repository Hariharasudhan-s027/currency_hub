import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleloginService {
  final auth = FirebaseAuth.instance;

  // ✅ Keep GoogleSignIn instance persistent
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? googleUser;

  Future<UserCredential?> firebaseGoogleLogin() async {
    try {
      googleUser = await _googleSignIn.signIn();

      // If user cancels the popup
      if (googleUser == null) return null;

      final auths = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: auths.idToken,
        accessToken: auths.accessToken,
      );
      return await auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('google login Error: $e');
    }
    return null;
  }

  Future<void> signOutFirebase() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      googleUser = null;
    } catch (e) {
      debugPrint('google logout Error: $e');
    }
  }
}
