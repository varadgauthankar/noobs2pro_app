import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/auth/auth_bloc.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/pages/splash_screen.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoggedInSkipped() {
      if (HiveService().isLoggedInSkipped != null) {
        return HiveService().isLoggedInSkipped!;
      } else {
        return false;
      }
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
       if (state is AuthAuthenticatedState) {
          return const MainPage();
        } else {
          if (_isLoggedInSkipped()) {
            return const MainPage();
          } else {
            return const AuthMainPage();
          }
        }
      },
    );
  }
}
