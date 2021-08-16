part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInButtonPressed extends SignInEvent {
  String? email;
  String? password;

  SignInButtonPressed({this.email, this.password});
}
