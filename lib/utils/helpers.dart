import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context,
    {required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String getFormattedDate(String dateString) {
  final DateTime dateTimeFromString = DateTime.parse(dateString);

  if (dateTimeFromString.year == DateTime.now().year) {
    return DateFormat('dd MMM').format(dateTimeFromString);
  } else {
    return DateFormat('dd MMM, yyyy').format(dateTimeFromString);
  }
}

Widget spacer({double height = 0, double width = 0}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

bool isThemeDark(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}

bool isValidEmail(String? input) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(input!);
}
