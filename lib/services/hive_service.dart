import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  static Box<Article> allArticlBox = Hive.box<Article>(kArticlesBox);
  static Box<int> savedArticlebox = Hive.box<int>(kSavedArticleBox);

  void insertArticles(List<Article> articles) {
    for (final article in articles) {
      allArticlBox.add(article);
    }
  }

  List<Article> getArticles() {
    final List<Article> articlesList = [];

    final articleBox = Hive.box(kArticlesBox);

    for (final article in articleBox.values as List<Article>) {
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
