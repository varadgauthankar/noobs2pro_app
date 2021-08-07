import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/api_service.dart';

import 'articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  @override
  Future<List<Article>> fetchArticles() async {
    return ApiService.getAllPosts();
  }
}
