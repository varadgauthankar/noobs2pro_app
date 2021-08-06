import 'package:noobs2pro_app/models/article.dart';

abstract class ArticlesRepository {
  Future<List<Article>> fetchArticles();
}
