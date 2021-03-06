import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

ThemeData light = ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  applyElevationOverlayColor: true,

  // AppBar
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        color: Colors.black,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  // text
  textTheme: const TextTheme(
    caption: TextStyle(
      fontSize: 14.0,
    ),
  ),
);

ThemeData dark = ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kGrey,
  applyElevationOverlayColor: true,

  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(kAccentColor),
    trackColor: MaterialStateProperty.all(kAccentColor.withOpacity(0.4)),
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: kGrey,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        color: Colors.white,
        fontSize: 22,
        fontStyle: FontStyle.italic,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  // text
  textTheme: const TextTheme(
    caption: TextStyle(
      fontSize: 14.0,
    ),
  ),
);
