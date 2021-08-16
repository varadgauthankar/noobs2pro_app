import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/buttons/primary_button.dart';
import 'package:noobs2pro_app/widgets/text_fields/base_text_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscureText = true;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isThemeDark(context) ? kPrimaryColorDark : kWhite,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            spacer(height: 22.0),
                            Align(
                              //ignore: avoid_redundant_argument_values
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/images/welcome.svg',
                                height: screenSize.height * 0.2,
                              ),
                            ),
                            spacer(height: 22.0),
                            spacer(height: 22.0),
                            BaseTextField(
                              label: 'Email',
                              hintText: 'Enter your email',
                              controller: emailController,
                              validator: (value) {
                                if (isValidEmail(value)) {
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
                                if (value!.length < 6) {
                                  return null;
                                }
                                return 'Passoword should be greater than 6 characters';
                              },
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            PrimaryButton(
                              heroTag: 'primary',
                              text: 'Sign In',
                              onPressed: () {},
                              width: screenSize.width,
                            ),
                            spacer(height: 12.0),
                            spacer(height: 33.0),
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
    );
  }
}
