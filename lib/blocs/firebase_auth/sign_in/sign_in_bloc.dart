import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';

part 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInIntialState());

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInButtonPressed) {
      yield SignInLoadingState();
      try {
        final User? user = await firebaseAuthService.signInEmailAndPassword(
          event.email!,
          event.password!,
        );
        yield SignInCompleteState(user!);
      } on FirebaseException catch (e) {
        yield SignInFailedState(e.code.replaceAll('-', ' '));
      }
    }
  }
}
