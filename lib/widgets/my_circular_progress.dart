import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

class MyCircularProgress extends StatelessWidget {
  const MyCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 14,
      width: 14,
      child: CircularProgressIndicator(
        color: kWhite,
        strokeWidth: 3,
      ),
    );
  }
}
