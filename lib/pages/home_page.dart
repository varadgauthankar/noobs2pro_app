import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:noobs2pro_app/widgets/home_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

// bvararad

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );
    _articlesBloc?.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => _articlesBloc!,
        child: BlocConsumer<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFetchError) {
              showMySnackBar(context, message: state.error);
            }
          },
          builder: (context, state) {
            return buildListOfArticles(screenDimention, state);
          },
        ),
      ),
    );
  }

  Widget buildListOfArticles(Size _screenDimention, ArticlesState state) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder(
      valueListenable: _hiveService.allArticlBox.listenable(),
      builder: (context, Box<Article> box, _) {
        if (state is ArticlesFetchLoading) {
          return const CenteredCircularProgressBar();
        } else if (state is ArticlesFetchComplete) {
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final Article _article = box.values.toList().elementAt(index);
              return HomeCard(
                _article,
                _screenDimention,
              );
            },
          );
        } else if (state is ArticlesFetchError) {
          //Todo: add graphics
          return const Text('Something went wrong');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
