import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';

Widget buildNetworkImage(
  ImageProvider<Object> image, {
  double? height,
  double? width,
  double? borderRadius,
}) {
  return Container(
    height: height ?? 200,
    width: width ?? double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: image,
      ),
    ),
  );
}

Widget buildPlaceholderImage(
  BuildContext context, {
  required double height,
  double? width,
  double? borderRadius,
}) {
  return Container(
    height: height,
    width: width ?? double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      color: isThemeDark(context) ? kGreyLighter : Colors.grey[100],
    ),
    child: Center(
      child: SvgPicture.asset(
        isThemeDark(context)
            ? 'assets/images/placeholder_dark.svg'
            : 'assets/images/placeholder_light.svg',
        height: height / 1.5,
      ),
    ),
  );
}
