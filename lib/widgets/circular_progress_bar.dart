import 'package:flutter/material.dart';

class CenteredCircularProgressBar extends StatelessWidget {
  const CenteredCircularProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
