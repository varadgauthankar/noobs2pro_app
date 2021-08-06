import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_bloc/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_bloc/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenDimention = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Text('g'));
  }
}

Widget buildListOfArticles(List<Article> _articles, Size _screenDimention) {
  return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        final Article _article = _articles[index];
        return HomeCard(_article, _screenDimention);
      });
}
