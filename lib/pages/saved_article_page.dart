import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firebase_auth.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:noobs2pro_app/widgets/exception_graphic_widget.dart';

class SavedArticlePage extends StatefulWidget {
  const SavedArticlePage({Key? key}) : super(key: key);

  @override
  _SavedArticlePageState createState() => _SavedArticlePageState();
}

class _SavedArticlePageState extends State<SavedArticlePage> {
  @override
  void initState() {
    super.initState();
  }

  List<Article> _getSavedArticlesFromAllArticleBox(Box<Article> allArticleBox) {
    final savedArticle = allArticleBox.values
        .where((element) => element.isSaved == true)
        .cast<Article>()
        .toList();
    return savedArticle;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimension = MediaQuery.of(context).size;

    return Scaffold(
      body: _buildListOfArticles(screenDimension),
    );
  }

  Widget _buildListOfArticles(Size _screenDimension) {
    final HiveService _hiveService = HiveService();
    return ValueListenableBuilder<Box<Article>>(
      valueListenable: _hiveService.allArticleBox.listenable(),
      builder: (context, box, _) {
        if (_getSavedArticlesFromAllArticleBox(box).isNotEmpty) {
          if (FirebaseAuthService().getCurrentUser() != null) {
            return _buildArticles(box);
          } else {
            return _notSignedInGraphic();
          }
        } else {
          if (FirebaseAuthService().getCurrentUser() != null) {
            return _noArticlesGraphic();
          } else {
            return _notSignedInGraphic();
          }
        }
      },
    );
  }

  Widget _buildArticles(Box<Article> box) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(6),
      itemCount: _getSavedArticlesFromAllArticleBox(box).length,
      itemBuilder: (context, index) {
        final Article _article =
            _getSavedArticlesFromAllArticleBox(box).elementAt(index);
        if (_article.isSaved!) {
          return ArticleCardSmall(_article);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _noArticlesGraphic() {
    return const ExceptionGraphic(
      message: 'No Saved Articles yet!',
      assetName: 'no_article.svg',
    );
  }

  Widget _notSignedInGraphic() {
    return const ExceptionGraphic(
      message: 'Sign in to save articles',
      assetName: 'no_article.svg',
    );
  }
}
