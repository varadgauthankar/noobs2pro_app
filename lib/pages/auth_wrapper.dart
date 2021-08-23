import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/auth/auth_bloc.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/auth_pages/main_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          print('splashhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
          //TODo : replace with splash screen
          return const Text('splash screem');
        } else if (state is AuthAuthenticatedState) {
          return HomePage(firebaseUserId: state.user.uid);
        } else {
          //return login?signUp page
          return const MainPage();
        }
      },
    );
  }
}
