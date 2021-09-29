import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoaded) {
      yield AuthLoadingState();
      try {
        final isSignedIn = firebaseAuthService.isSignedIn();

        if (isSignedIn) {
          final currentUser = firebaseAuthService.getCurrentUser();
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
