import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/auth/auth_event.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/auth/auth_state.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoaded) {
      try {
        final isSignedIn = await firebaseAuthService.isSignedIn();
        if (isSignedIn) {
          final currentUser = await firebaseAuthService.getCurrentUser();
          yield AuthAuthenticatedState(currentUser!);
        } else {
          yield AuthUnAuthenticatedState();
        }
      } catch (e) {
        yield AuthUnAuthenticatedState();
      }
    }
  }
}
