import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  User user;
  AuthAuthenticatedState(this.user);
}

class AuthUnAuthenticatedState extends AuthState {}
