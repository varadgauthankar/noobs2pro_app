import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noobs2pro_app/constants/strings.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/auth_pages/auth_main_page.dart';
import 'package:noobs2pro_app/widgets/my_material_banner.dart';
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

ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
    showMyMaterialBanner(
  BuildContext context, {
  required String title,
  required String subtitle,
  bool isSignInBanner = false,
}) {
  return ScaffoldMessenger.of(context).showMaterialBanner(
    myMaterialBanner(
      title: title,
      subTitle: subtitle,
      isSignInBanner: isSignInBanner,
      onDismissPressed: () {
        ScaffoldMessenger.of(context).clearMaterialBanners();
      },
      onSignInButtonPressed: () {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthMainPage()),
        );
      },
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
