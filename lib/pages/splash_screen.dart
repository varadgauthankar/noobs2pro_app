import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: isThemeDark(context) ? kGrey : kWhite,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: screenSize.height * .3,
          ),
        ),
      ),
    );
  }
}
