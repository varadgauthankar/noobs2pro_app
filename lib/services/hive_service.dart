import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  Box<Article> box = Hive.box(kArticlesBox);

  void insertArticles(List<Article> articles) {
    for (final article in articles) {
      box.add(article);
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
}
