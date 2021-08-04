import 'package:noobs2pro_app/models/article.dart';
import 'package:http/http.dart' as http;

import 'articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  @override
  Future<List<Article>> fetchArticles() async {
    try {
      final url = Uri.parse(
          'https://www.noobs2pro.com/wp-json/wp/v2/posts?per_page=50');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> articles = response.body as List<dynamic>;

        final List<Article> articlesList = [];

        for (final article in articles) {
          articlesList.add(Article.fromJson(article as Map<String, dynamic>));
        }

        return articlesList;
      } else {
        Exception('failed');
      }
    } catch (e) {
      Exception(e);
    }
    throw UnimplementedError();
  }
}
