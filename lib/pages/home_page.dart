import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

// bvararad

class HomePage extends StatefulWidget {
  final String firebaseUserId;
  const HomePage({Key? key, required this.firebaseUserId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticlesBloc? _articlesBloc;

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: widget.firebaseUserId,
    );
    _articlesBloc?.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Open drawer',
            );
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => _articlesBloc!,
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: BlocBuilder<ArticlesBloc, ArticlesState>(
            builder: (context, state) {
              if (state is ArticlesFetchError) {
                return Text(state.error);
              } else if (state is ArticlesFetchLoading) {
                return const CenteredCircularProgressBar();
              } else if (state is ArticlesFetchComplete) {
                return buildListOfArticles(screenDimention);
              }
              return const Text('Failed');
            },
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }

  Widget buildListOfArticles(Size _screenDimention) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder(
      valueListenable: _hiveService.allArticlBox.listenable(),
      builder: (context, Box<Article> box, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final Article _article = box.values.toList().elementAt(index);
            return HomeCard(
              _article,
              _screenDimention,
              firebaseUserId: widget.firebaseUserId,
            );
          },
        );
      },
    );
  }
}
