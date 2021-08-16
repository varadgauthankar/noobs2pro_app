part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInIntialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInCompleteState extends SignInState {
  User user;
  SignInCompleteState(this.user);
}

class SignInFailedState extends SignInState {
  String error;
  SignInFailedState(this.error);
}
