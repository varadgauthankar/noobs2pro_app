import 'package:hive_flutter/hive_flutter.dart';
import 'package:noobs2pro_app/constants/hive_boxes.dart';
import 'package:noobs2pro_app/models/article.dart';

class HiveService {
  Box<Article> allArticleBox = Hive.box<Article>(kArticlesBox);
  Box<Article> searchArticleBox = Hive.box<Article>(kSearchArticlesBox);
  Box<Article> categoryArticlesBox = Hive.box<Article>(kCategoryArticlesBox);
  Box<Article> savedArticlesBox = Hive.box<Article>(kSavedArticlesObjectBox);
  Box<int> fsavedArticleIdBox = Hive.box<int>(kSavedArticleBox);

  Future<void> insertArticle(Article article) async {
    // await allArticleBox
    await allArticleBox.add(article);
  }

  Future<void> insertSearchedArticle(Article article) async {
    await searchArticleBox.add(article);
  }

  Future<void> insertCategoryArticles(Article article) async {
    await categoryArticlesBox.add(article);
  }

  List<Article> getArticles() {
    return allArticleBox.values.toList();
  }

  List<Article> getArticlesShuffled() {
    return allArticleBox.values.toList()..shuffle();
  }

  List<Article> getSearchedArticles() {
    final List<Article> articlesList = [];

    for (final article in searchArticleBox.values.toList()) {
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

  Future<void> saveArticle(Article article) async {
    // if (allArticleBox.containsKey(article.key)) {
    //   await allArticleBox.put(article.key, article..isSaved = true);
    // } else {
    //   await allArticleBox.add(article..isSaved = true);
    // }
    // await allArticleBox.put(article.key, article..isSaved = true);

    final articleFromBox =
        allArticleBox.values.firstWhere((element) => element.id == article.id);

    await allArticleBox.put(articleFromBox.key, article..isSaved = true);
  }

  Future<void> unSaveArticle(Article article, dynamic key) async {
    await allArticleBox.put(key, article..isSaved = false);
  }
}
