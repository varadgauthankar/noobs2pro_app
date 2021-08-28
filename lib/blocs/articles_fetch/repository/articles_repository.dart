import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firestore_service.dart';

abstract class ArticlesRepository {
  Future<List<Article>> fetchArticles(FirestoreService f);
  Future<List<Article>> fetchArticlesByQuery(FirestoreService f,
      {required String query});
}
