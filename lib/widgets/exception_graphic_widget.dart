import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';

class ExceptionGraphic extends StatelessWidget {
  final String message;
  final String assetName;
  const ExceptionGraphic({
    Key? key,
    required this.message,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenDimension = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/$assetName',
            height: screenDimension.height * .2222,
          ),
          spacer(height: 12),
          Text(
            message,
            style: searchPageTop.copyWith(
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
