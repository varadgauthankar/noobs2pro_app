import 'package:flutter/material.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: light,
      home: const HomePage(),
    );
  }
}
