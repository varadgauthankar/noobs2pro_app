import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpIntialState());

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoadingState();
      try {
        final User? user = await firebaseAuthService.signUpUserWithEmailPass(
          event.email!,
          event.password!,
        );
        HiveService().loggedInNotSkipped();

        yield SignUpCompleteState(user!);
      } on FirebaseAuthException catch (e) {
        yield SignUpFailedState(e.code);
      } on FirebaseException catch (e) {
        yield SignUpFailedState(e.code.replaceAll('-', ' '));
      }
    }
  }
}
