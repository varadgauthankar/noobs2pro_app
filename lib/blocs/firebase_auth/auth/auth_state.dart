part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  User user;
  AuthAuthenticatedState(this.user);
}

class AuthUnAuthenticatedState extends AuthState {}
