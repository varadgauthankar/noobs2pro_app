import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:noobs2pro_app/utils/firebase_auth_error_codes.dart';

class FirebaseAuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // sign up with email
  Future<User?> signUpUserWithEmailPass(String email, String password) async {
    try {
      final authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } on FirebaseAuthException catch (e) {
      String authError = "";
      switch (e.code) {
        case 'invalid-email':
          authError = 'Invalid Email';
          break;
        case 'email-already-in-use':
          authError = 'email already in use';
          break;
        case 'weak-password':
          authError = 'Weak password';
          break;
      }
      throw Exception(authError);
    }
  }

  // sign in with email and password
  Future<User?> signInEmailAndPassword(String email, String password) async {
    try {
      final authresult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authresult.user;
    } on PlatformException catch (e) {
      String authError = "";

      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // check signIn
  bool isSignedIn() {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  // get current user
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  String? getCurrentUserUid() {
    return firebaseAuth.currentUser?.uid;
  }
}
