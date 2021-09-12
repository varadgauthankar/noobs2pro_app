import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  Box<Article> allArticlBox = Hive.box<Article>(kArticlesBox);
  Box<Article> searcgArticlBox = Hive.box<Article>(kSearchArticlesBox);
  Box<Article> categoryArticlesBox = Hive.box<Article>(kCategoryArticlesBox);
  Box<Article> savedArticlesBox = Hive.box<Article>(kSavedArticlesObjectBox);
  Box<int> savedArticleIdBox = Hive.box<int>(kSavedArticleBox);

  Future<void> insertArticle(Article article) async {
    await allArticlBox.add(article);
  }

  Future<void> insertSearchedArticle(Article article) async {
    await searcgArticlBox.add(article);
  }

  Future<void> insertCategoryArticles(Article articl) async {
    await categoryArticlesBox.add(articl);
  }

  // i dont know why i am runnign a loop here
  // but i am afraid to change
  // TODO come back later here
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

  List<Article> getCategoryArticles() {
    final List<Article> articlesList = [];

    for (final article in categoryArticlesBox.values.toList()) {
      articlesList.add(article);
    }
    return articlesList;
  }

  Future<void> saveArticle(Article article, dynamic key) async {
    if (allArticlBox.containsKey(key)) {
      await allArticlBox.put(key, article..isSaved = true);
    } else {
      await allArticlBox.add(article..isSaved = true);
    }
    savedArticleIdBox.add(article.id!);
  }

  Future<void> unSaveArticle(Article article, dynamic key) async {
    await allArticlBox.put(key, article..isSaved = false);
    savedArticleIdBox
        .deleteAt(savedArticleIdBox.values.toList().indexOf(article.id!));
  }
}
