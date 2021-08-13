import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/pages/pages.dart';
import 'package:noobs2pro_app/utils/theme.dart';
import 'models/models.dart';

// ignore: avoid_void_async
void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Article>('articlesBox');
  Hive.registerAdapter(ArticleAdapter());
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
