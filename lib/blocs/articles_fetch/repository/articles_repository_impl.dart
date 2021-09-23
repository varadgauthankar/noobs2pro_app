import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/api_service.dart';
import 'package:noobs2pro_app/services/firestore_service.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

import 'articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final HiveService _hiveService = HiveService();

  @override
  Future<List<Article>> fetchArticles(FirestoreService fireStore) async {
    final List<dynamic> ids =
        await fireStore.getSavedArticleIds() as List<dynamic>;

    final List<Article> articles = await ApiService.getAllPosts();

    // reversing the list so that every new item is added to top
    // also reversed again in ui, listView
    final List<Article> reversedArticlesList = articles.reversed.toList();

    // check for new articles and add to box
    for (final Article article in reversedArticlesList) {
      if (_hiveService.allArticleBox.values
          .toList()
          .every((element) => element.id != article.id)) {
        // put new articles in box with "isSaved"
        if (ids.contains(article.id)) {
          await _hiveService.insertArticle(article..isSaved = true);
        } else {
          await _hiveService.insertArticle(article);
        }
      }
    }
    return _hiveService.getArticles();
  }

  @override
  Future<List<Article>> fetchArticlesByQuery(FirestoreService fireStore,
      {required String query}) async {
    final List<dynamic> ids =
        await fireStore.getSavedArticleIds() as List<dynamic>;

    final List<Article> articles =
        await ApiService.getPostsBySearchQuery(query);
    final List<Article> newArticles = [];

    for (final Article article in articles) {
      if (ids.contains(article.id)) {
        newArticles.add(article..isSaved = true);
      } else {
        newArticles.add(article);
      }
    }
    return newArticles;
  }

  @override
  Future<List<Article>> fetchArticlesByCategory(
      FirestoreService fireStore, int id) async {
    final List<dynamic> ids =
        await fireStore.getSavedArticleIds() as List<dynamic>;

    final List<Article> articles = await ApiService.getPostsByCategory(id);
    final List<Article> newArticles = [];

    for (final Article article in articles) {
      if (ids.contains(article.id)) {
        newArticles.add(article..isSaved = true);
      } else {
        newArticles.add(article);
      }
    }
    return newArticles;
  }

  @override
  Future<List<Article>> fetchExploreArticles(FirestoreService fireStore) async {
    final List<dynamic> ids =
        await fireStore.getSavedArticleIds() as List<dynamic>;

    final List<Article> articles = await ApiService.getAllPosts();

    final List<Article> processedArticles = [];

    for (final Article article in articles) {
      if (ids.contains(article.id)) {
        processedArticles.add(article..isSaved = true);
      } else {
        processedArticles.add(article);
      }
    }

    // right now just shuffling the all articles list 🤣
    // which basically acts as a "Explore" feature lol
    return processedArticles..shuffle();
  }
}
