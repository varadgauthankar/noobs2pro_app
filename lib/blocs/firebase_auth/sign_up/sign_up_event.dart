part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  String? email;
  String? password;

  SignUpButtonPressed({this.email, this.password});
}
