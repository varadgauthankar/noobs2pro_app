import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:noobs2pro_app/widgets/circular_progress_bar.dart';

class SearchedArticlePaged extends StatefulWidget {
  final String query;

  const SearchedArticlePaged({Key? key, required this.query}) : super(key: key);
  @override
  _SearchedArticlePagedState createState() => _SearchedArticlePagedState();
}

class _SearchedArticlePagedState extends State<SearchedArticlePaged> {
  ArticlesBloc? _articlesBloc;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );
    _articlesBloc?.add(FetchArticleByQueryEvent(widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.query),
      ),
      body: BlocProvider(
        create: (context) => _articlesBloc!,
        child: BlocConsumer<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFetchComplete) {
              setState(() {
                _articles = state.articles;
              });
            }
            if (state is ArticlesFetchError) {
              showMySnackBar(context, message: state.error);
            }
          },
          builder: (context, state) {
            if (state is ArticlesFetchLoading) {
              return const CenteredCircularProgressBar();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: _articles.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final _article = _articles[index];
                return ArticleCardSmall(_article);
              },
            );
          },
        ),
      ),
    );
  }
}
