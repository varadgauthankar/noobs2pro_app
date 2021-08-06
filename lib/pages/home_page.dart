import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/bloc/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/bloc/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/models.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArticlesBloc _articlesBloc = ArticlesBloc(ArticlesRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _articlesBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocProvider(
        create: (context) => _articlesBloc,
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: BlocBuilder<ArticlesBloc, ArticlesState>(
              builder: (context, state) {
            if (state is ArticlesFetchError) {
              return const Text('err');
            } else if (state is ArticlesFetchLoading) {
              return const CenteredCircularProgressBar();
            } else if (state is ArticlesFetchComplete) {
              return buildListOfArticles(state.articles, screenDimention);
            }
            return const Text('ehahah');
          }),
        ),
      ),
    );
  }
}

Widget buildListOfArticles(List<Article> articles, Size screenDimention) {
  return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final Article article = articles[index];
        return Text(article.title ?? '');
      });
}
