import 'package:flutter/material.dart';
import 'package:noobs2pro_app/utils/colors.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? width;
  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: kAccentColorLight,
          primary: Colors.black,
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
        child: Text(text),
      ),
    );
  }
}
