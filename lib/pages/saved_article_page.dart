import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedArticlePage extends StatefulWidget {
  const SavedArticlePage({Key? key}) : super(key: key);

  @override
  _SavedArticlePageState createState() => _SavedArticlePageState();
}

class _SavedArticlePageState extends State<SavedArticlePage> {
  late ArticlesBloc _articlesBloc;
  bool isFirstLaunch = false;

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );

    //  _articlesBloc.add(FetchArticlesEvent());
  }

  List<Article> _getSavedArticlesFromAllArticleBox(Box allArticleBox) {
    return allArticleBox.values
        .where((element) => element.isSaved == true)
        .toList() as List<Article>;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimention = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider(
        create: (context) => _articlesBloc,
        child: BlocConsumer<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFetchError) {
              showMySnackBar(context, message: state.error);
            }
          },
          builder: (context, state) {
            return _buildListOfArticles(screenDimention, state);
          },
        ),
      ),
    );
  }

  Widget _buildListOfArticles(Size _screenDimention, ArticlesState state) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder(
      valueListenable: _hiveService.allArticlBox.listenable(),
      builder: (context, Box<Article> box, _) {
        if (isFirstLaunch) {
          //show loading indicator
          if (state is ArticlesFetchLoading) {
            return const CenteredCircularProgressBar();
          }
          //articles are fetched
          else if (state is ArticlesFetchComplete) {
            if (_getSavedArticlesFromAllArticleBox(box).isNotEmpty) {
              return _buildArticles(box);
            } else {
              return _noArticlesGraphic();
            }
          } else {
            return _noArticlesGraphic();
          }
        } else {
          if (_getSavedArticlesFromAllArticleBox(box).isNotEmpty) {
            return _buildArticles(box);
          } else {
            return _noArticlesGraphic();
          }
        }
      },
    );
  }

  Widget _buildArticles(Box<Article> box) {
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: _getSavedArticlesFromAllArticleBox(box).length,
      itemBuilder: (context, index) {
        final Article _article = box.values.toList()[index];

        if (_article.isSaved!) {
          return ArticleCardSmall(_article);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _noArticlesGraphic() {
    return const Center(
      child: Text('NO ARTICLES'),
    );
  }
}
