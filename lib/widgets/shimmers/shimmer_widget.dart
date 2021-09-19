import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerWidget({
    Key? key,
    required this.height,
    this.width = double.maxFinite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isThemeDark(context) ? kBlack : Colors.grey[100]!,
      highlightColor:
          isThemeDark(context) ? Colors.grey[800]! : Colors.grey[300]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isThemeDark(context) ? kBlack : kWhite,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
