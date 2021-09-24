import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

MaterialBanner myMaterialBanner({
  required String title,
  String? subTitle,
  required VoidCallback onButtonPressed,
}) {
  return MaterialBanner(
    leading: const Icon(EvaIcons.alertCircleOutline),
    content: ListTile(
      title: Text(
        title,
        style: articleTitle,
      ),
      subtitle: Text(
        subTitle ?? '',
        style: categoryItems,
      ),
    ),
    backgroundColor: kDanger,
    actions: [
      IconButton(
        onPressed: onButtonPressed,
        icon: const Icon(EvaIcons.checkmark),
      ),
    ],
  );
}
