import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  Box<Article> allArticlBox = Hive.box<Article>(kArticlesBox);
  Box<Article> searcgArticlBox = Hive.box<Article>(kSearchArticlesBox);
  Box<int> savedArticlebox = Hive.box<int>(kSavedArticleBox);

  void insertArticle(Article article) {
    allArticlBox.add(article);
  }

  void insertSearchedArticle(Article article) {
    searcgArticlBox.add(article);
  }

  List<Article> getArticles() {
    final List<Article> articlesList = [];

    for (final article in allArticlBox.values.toList()) {
      articlesList.add(article);
    }
    return articlesList;
  }

  List<Article> getSearchedArticles() {
    final List<Article> articlesList = [];

    for (final article in searcgArticlBox.values.toList()) {
      articlesList.add(article);
    }
    return articlesList;
  }

  void saveArticle(Article article, dynamic key) {
    allArticlBox.put(key, article..isSaved = true);
    savedArticlebox.add(article.id!);
  }

  void unSaveArticle(Article article, dynamic key) {
    allArticlBox.put(key, article..isSaved = false);
    savedArticlebox
        .deleteAt(savedArticlebox.values.toList().indexOf(article.id!));
  }
}
