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
