import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/sign_up/sign_up_bloc.dart';
import 'package:noobs2pro_app/pages/auth_pages/signin_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/animated_blob.dart';
import 'package:noobs2pro_app/widgets/buttons/primary_button.dart';
import 'package:noobs2pro_app/widgets/my_circular_progress.dart';
import 'package:noobs2pro_app/widgets/text_fields/base_text_field.dart';
import 'package:validators/validators.dart' as validator;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final obscureText = true;

  bool isFormValidate() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  final SignUpBloc _signUpBloc = SignUpBloc();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isThemeDark(context) ? kPrimaryColorDark : kWhite,
      body: BlocProvider(
        create: (context) => _signUpBloc,
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpCompleteState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            } else if (state is SignUpFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text('Hello,',
                                style: sloganStyle.copyWith(fontSize: 24)),
                            Text(
                              'Sign up!',
                              style: appNameStyle.copyWith(
                                  color: kBlack, fontSize: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                          } else {
                            return 'Please enter a valid email';
                          }
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
                      spacer(height: 24),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return PrimaryButton(
                            heroTag: 'primary',
                            onPressed: () {
                              if (isFormValidate()) {
                                _signUpBloc.add(SignUpButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                              }
                            },
                            width: screenSize.width,
                            child: state is SignUpLoadingState
                                ? const MyCircularProgress()
                                : const Text('SIGN UP'),
                          );
                        },
                      ),
                      spacer(height: 12.0),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SigninPage()),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text("Already have an account? SIGN IN"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
