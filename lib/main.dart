import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/blocs/firebase_auth/auth/auth_bloc.dart';
import 'package:noobs2pro_app/blocs/theme_bloc/bloc/bloc/theme_bloc.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/pages/auth_wrapper.dart';
import 'package:noobs2pro_app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<Article>(ArticleAdapter());
  Hive.registerAdapter<Media>(MediaAdapter());
  await Hive.openBox<Article>(kArticlesBox);
  await Hive.openBox<int>(kSavedArticleBox);
  await Hive.openBox<Article>(kSearchArticlesBox);
  await Hive.openBox<Article>(kCategoryArticlesBox);
  await Hive.openBox<Article>(kSavedArticlesObjectBox);
  await Hive.openBox<int>(kThemeBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Noobs2pro',
            theme: light,
            darkTheme: dark,
            themeMode: state.themeMode,
            home: BlocProvider(
              create: (context) => AuthBloc()..add(AppLoaded()),
              child: const AuthWrapper(),
            ),
          );
        },
      ),
    );
  }
}
