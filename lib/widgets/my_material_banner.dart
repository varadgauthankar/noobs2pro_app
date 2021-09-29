import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

MaterialBanner myMaterialBanner({
  required String title,
  String? subTitle,
  required bool isSignInBanner,
  VoidCallback? onSignInButtonPressed,
  VoidCallback? onDismissPressed,
}) {
  return MaterialBanner(
    leading: Icon(EvaIcons.alertCircleOutline,
        color: isSignInBanner ? kWhite : kBlack),
    content: Padding(
      padding: EdgeInsets.symmetric(vertical: isSignInBanner ? 0.0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                articleTitle.copyWith(color: isSignInBanner ? kWhite : kBlack),
          ),
          Text(
            subTitle ?? '',
            style:
                categoryItems.copyWith(color: isSignInBanner ? kWhite : kBlack),
          ),
        ],
      ),
    ),
    backgroundColor: isSignInBanner ? kPrimaryColor : kDanger,
    actions: [
      if (!isSignInBanner)
        IconButton(
          onPressed: onDismissPressed,
          icon: Icon(
            EvaIcons.checkmark,
            color: isSignInBanner ? kWhite : kBlack,
          ),
        )
      else
        TextButton(
          onPressed: onSignInButtonPressed,
          child: const Text('SIGN IN'),
        ),
      if (isSignInBanner)
        TextButton(
          onPressed: onDismissPressed,
          child: const Text('NOT NOW'),
        )
    ],
  );
}
