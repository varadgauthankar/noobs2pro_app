import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noobs2pro_app/constants/strings.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:share/share.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMySnackBar(
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
  return RegExp(r'^\S+@\S+$').hasMatch(input!);
}

void goToPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void shareArticle(Article article) {
  Share.share(
    '''
    Check out this article from Noobs2pro.com
    ${article.title}
    ${article.link}
    
    Download the app: $kAppLink
    ''',
    subject: 'Article from Noobs2pro',
  );
}
