import 'package:flutter/material.dart';

Widget buildNetworkImage(
  ImageProvider<Object> image, {
  double? height,
  double? width,
}) {
  return Container(
    height: height ?? 200,
    width: width ?? double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: image,
      ),
    ),
  );
}

Widget buildPlaceholderImage({
  double? height,
  double? width,
}) {
  return Container(
    height: height ?? 200,
    width: width ?? double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: const DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage('assets/images/placeholder.png'),
      ),
    ),
  );
}
