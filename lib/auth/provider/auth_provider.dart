import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/auth_response.dart';

class AuthProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<bool> bootAuthenticate() async {
    var currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      currentUser = await _firebaseAuth.authStateChanges().first;

      if (currentUser != null) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<AuthResponse> legacyAuth({
    required String email,
    required String password,
    required bool persistAuth,
    String? userName,
  }) async {
    if (!persistAuth) {
      await _firebaseAuth.setPersistence(Persistence.NONE);
    }

    final response = await signIn(email: email, password: password);

    if (response.success && (response.credential != null)) {
      return response;
    } else {
      return AuthResponse(success: false, message: response.message);
    }
  }

  Future<bool> signOutUser() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResponse(success: true, credential: credential);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        return AuthResponse(
            success: false, message: 'The email provided is invalid.');
      } else if (error.code == 'user-disabled') {
        return AuthResponse(
            success: false, message: 'Sorry! Your account is disabled.');
      } else if (error.code == 'user-not-found') {
        return AuthResponse(
            success: false, message: 'No user found for that email.');
      } else if (error.code == 'wrong-password') {
        return AuthResponse(
            success: false, message: 'Wrong password provided for that user.');
      } else {
        return AuthResponse(
            success: false, message: 'Oops! Some error occured.');
      }
    } catch (error) {
      return AuthResponse(success: false, message: 'Oops! Some error occured.');
    }
  }
}
