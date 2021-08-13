import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

ThemeData light = ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kAccentColor,
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
    textTheme: const TextTheme(
        caption: TextStyle(
      fontSize: 14.0,
    )));
