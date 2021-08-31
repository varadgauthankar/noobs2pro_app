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

    await _hiveService.allArticlBox.clear();

    for (final Article article in articles) {
      // final List<dynamic> i = ids as List<dynamic>;
      if (ids.contains(article.id)) {
        _hiveService.insertArticle(article..isSaved = true);
      } else {
        _hiveService.insertArticle(article);
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

    await _hiveService.searcgArticlBox.clear();

    for (final Article article in articles) {
      // final List<dynamic> i = ids as List<dynamic>;
      if (ids.contains(article.id)) {
        _hiveService.insertSearchedArticle(article..isSaved = true);
      } else {
        _hiveService.insertSearchedArticle(article);
      }
    }
    return _hiveService.getSearchedArticles();
  }
}
