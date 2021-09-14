import 'package:flutter/material.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/hive_service.dart';
import 'package:noobs2pro_app/widgets/article_card_small.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    print(savedArticle.length);
    for (final article in savedArticle) {
      print(article.title);
    }

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
          return _buildArticles(box);
        } else {
          return _noArticlesGraphic();
        }
      },
    );
  }

  Widget _buildArticles(Box<Article> box) {
    return ListView.builder(
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
    return const Center(
      child: Text('NO ARTICLES'),
    );
  }
}
