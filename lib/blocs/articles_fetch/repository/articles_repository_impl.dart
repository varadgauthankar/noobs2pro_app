import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/api_service.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

import 'articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  @override
  Future<List<Article>> fetchArticles() async {
    final List<Article> articles = await ApiService.getAllPosts();
    HiveService().insertArticles(articles);
    return articles;
  }
}
