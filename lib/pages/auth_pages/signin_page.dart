import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/sign_in/sign_in_bloc.dart';
import 'package:noobs2pro_app/pages/auth_pages/signup_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/animated_blob.dart';
import 'package:noobs2pro_app/widgets/buttons/primary_button.dart';
import 'package:noobs2pro_app/widgets/my_circular_progress.dart';
import 'package:noobs2pro_app/widgets/text_fields/base_text_field.dart';
import 'package:validators/validators.dart' as validator;

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscureText = true;

  final _signInBloc = SignInBloc();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isThemeDark(context) ? kPrimaryColorDark : kWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocProvider(
          create: (context) => _signInBloc,
          child: BlocListener<SignInBloc, SignInState>(
            listener: (context, state) {
              if (state is SignInCompleteState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                );
              } else if (state is SignInFailedState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: const AlignmentDirectional(-1, 0.0),
                      children: [
                        const Align(
                          widthFactor: 0.2,
                          child: AnimatedBlob(),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome Back',
                                style: sloganStyle.copyWith(fontSize: 24)),
                            Text('Sign in!',
                                style: appNameStyle.copyWith(
                                    color: kBlack, fontSize: 40)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // column of text fields and button
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BaseTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: emailController,
                        validator: (value) {
                          if (validator.isEmail(value!)) {
                            return null;
                          }
                          return 'Please enter a valid Email';
                        },
                      ),
                      spacer(height: 12),
                      BaseTextField(
                        obscureText: obscureText,
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters long';
                            } else {
                              return null;
                            }
                          } else {
                            return 'Please enter the password';
                          }
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            FirebaseAuthService()
                                .forgetPassword('gvarad1601@gmail.com');
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            heroTag: 'primary',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signInBloc.add(SignInButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                              }
                            },
                            width: screenSize.width,
                            child: state is SignInLoadingState
                                ? const MyCircularProgress()
                                : const Text('SIGN IN'),
                          );
                        },
                      ),
                      spacer(height: 12.0),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupPage()),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text("Don't have an account? SIGN UP"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
