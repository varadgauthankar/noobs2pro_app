import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  static const String boxName = 'articlesBox';

  Box<Article> box = Hive.box(boxName);

  void insertArticles(List<Article> articles) {
    for (final article in articles) {
      box.add(article);
    }
  }

  List<Article> getArticles() {
    final List<Article> articlesList = [];

    final articleBox = Hive.box(boxName);

    for (final article in articleBox.values as List<Article>) {
      articlesList.add(article);
    }

    return articlesList;
  }
}
