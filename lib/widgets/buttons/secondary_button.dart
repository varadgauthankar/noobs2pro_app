import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 52,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          primary: isThemeDark(context) ? kWhite : Colors.black,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          side: const BorderSide(color: kAccentColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
