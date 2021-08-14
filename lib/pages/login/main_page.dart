import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/constants/strings.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/buttons/primary_button.dart';
import 'package:noobs2pro_app/widgets/buttons/secondary_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isThemeDark(context) ? kPrimaryColorDark : kWhite,
        body: SizedBox(
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          spacer(height: 22.0),
                          SvgPicture.asset(
                            'assets/images/welcome.svg',
                            height: screenSize.height * 0.2,
                          ),
                          spacer(height: 12.0),
                          const Text('Welcome to', style: welcomeStyle),
                          Text(kAppName, style: appNameStyle),
                          spacer(height: 12.0),
                          Text(kSlogan, style: sloganStyle),
                        ],
                      ),
                      Column(
                        children: [
                          PrimaryButton(
                            text: 'Sign In',
                            onPressed: () {},
                            width: screenSize.width,
                          ),
                          spacer(height: 12.0),
                          SecondaryButton(
                            text: 'Sign Up',
                            onPressed: () {},
                            width: screenSize.width,
                          ),
                          spacer(height: 33.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                primary: Colors.grey,
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: const Text('Skip this'),
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
    );
  }
}
