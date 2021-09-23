import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/bloc/articles_bloc.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository_impl.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/utils/colors.dart';
import 'package:noobs2pro_app/utils/helpers.dart';
import 'package:noobs2pro_app/utils/text_styles.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:noobs2pro_app/widgets/exception_graphic_widget.dart';
import 'package:noobs2pro_app/widgets/shimmers/small_article_card.dart';

class CategoryArticlesPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;
  const CategoryArticlesPage({
    Key? key,
    required this.categoryId,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  _CategoryArticlesPageState createState() => _CategoryArticlesPageState();
}

class _CategoryArticlesPageState extends State<CategoryArticlesPage> {
  ArticlesBloc? _articlesBloc;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();

    _articlesBloc = ArticlesBloc(
      ArticlesRepositoryImpl(),
      firebaseUserId: FirebaseAuthService().getCurrentUserUid() ?? '',
    );

    _articlesBloc?.add(FetchCategoryArticlesEvent(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimension = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
          style: appBarTitleStyle.copyWith(
            color: isThemeDark(context) ? kWhite : kBlack,
          ),
        ),
      ),
      body: buildListOfArticles(screenDimension),
    );
  }

  Widget buildListOfArticles(Size _screenDimension) {
    return BlocProvider(
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
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(6),
              itemCount: 12,
              itemBuilder: (context, index) {
                return const ShimmerSmallArticleCard();
              },
            );
          }

          if (_articles.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(6),
              itemCount: _articles.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final _article = _articles[index];
                return ArticleCardSmall(_article);
              },
            );
          } else {
            return const ExceptionGraphic(
              message: 'No results',
              assetName: 'void.svg',
            );
          }
        },
      ),
    );
  }
}
