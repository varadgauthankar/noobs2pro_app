import 'package:flutter/material.dart';
import 'package:noobs2pro_app/constants/strings.dart';
import 'package:noobs2pro_app/pages/auth_pages/signin_page.dart';
import 'package:noobs2pro_app/pages/auth_pages/signup_page.dart';
import 'package:noobs2pro_app/pages/main_page.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/animated_blob.dart';
import 'package:noobs2pro_app/widgets/buttons/primary_button.dart';
import 'package:noobs2pro_app/widgets/buttons/secondary_button.dart';

class AuthMainPage extends StatefulWidget {
  const AuthMainPage({Key? key}) : super(key: key);

  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isThemeDark(context) ? kPrimaryColorDark : kWhite,
      body: Stack(
        children: [
          const Align(
            heightFactor: 0.7,
            widthFactor: 0.2,
            child: AnimatedBlob(),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: screenSize.height * 0.35,
                          ),
                          spacer(height: 6.0),
                          const Text('Welcome to', style: welcomeStyle),
                          Text(kAppName, style: appNameStyle),
                          spacer(height: 12.0),
                          Text(kSlogan, style: sloganStyle),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      PrimaryButton(
                        heroTag: 'primary',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigninPage(),
                            ),
                          );
                        },
                        width: screenSize.width,
                        child: const Text('SIGN IN'),
                      ),
                      spacer(height: 12.0),
                      SecondaryButton(
                        text: 'SIGN UP',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        width: screenSize.width,
                      ),
                      spacer(height: 12.0),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.grey,
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text("Skip Login"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
