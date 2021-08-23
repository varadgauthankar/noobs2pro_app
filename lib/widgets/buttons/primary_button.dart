import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final double? width;
  final String heroTag;
  const PrimaryButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: SizedBox(
        width: width,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: kAccentColor,
            primary: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}