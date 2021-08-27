import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/sign_up/sign_up_bloc.dart';
import 'package:noobs2pro_app/pages/home_page.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
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

    return SafeArea(
      child: Scaffold(
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
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // backgtound
                    Container(
                      width: screenSize.width,
                      height: screenSize.height / 2,
                      color: kAccentColor,
                    ),
                    Center(
                      child: Container(
                        height: screenSize.height * 0.8,
                        width: screenSize.width,
                        margin: const EdgeInsets.all(18.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        decoration: BoxDecoration(
                          color: isThemeDark(context) ? kPrimaryColor : kWhite,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: kBlack.withOpacity(0.2),
                              offset: const Offset(2, 2),
                              blurRadius: 12,
                            )
                          ],
                        ),

                        //! top image
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            spacer(height: 22.0),
                            SvgPicture.asset(
                              'assets/images/welcome.svg',
                              height: screenSize.height * 0.2,
                            ),
                            spacer(height: 22.0),
                            spacer(height: 22.0),

                            //! bottom stuff
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
                                      // if (value!.isNotEmpty) {
                                      //   if (isValidEmail(value)) {
                                      //     return 'Please enter a valid email';
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // } else {
                                      //   return 'Please enter the email';
                                      // }
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
                                          return 'Password should be atleast 6 characters long';
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
                                            : const Text('Sign Up'),
                                      );
                                    },
                                  ),
                                  spacer(height: 12.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        primary: Colors.grey,
                                        textStyle: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      child: const Text('Cancel'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
