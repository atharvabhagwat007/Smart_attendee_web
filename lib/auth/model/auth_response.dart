import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  final bool success;
  final String? message;
  final UserCredential? credential;

  AuthResponse({required this.success, this.message, this.credential});

  @override
  String toString() {
    return '<AuthResponse>{success:$success, message:$message, credential:$credential}';
  }
}
