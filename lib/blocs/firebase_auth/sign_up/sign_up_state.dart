part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpIntialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpCompleteState extends SignUpState {
  User user;
  SignUpCompleteState(this.user);
}

class SignUpFailedState extends SignUpState {
  String error;
  SignUpFailedState(this.error);
}
