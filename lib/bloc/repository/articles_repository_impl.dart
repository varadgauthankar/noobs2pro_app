import 'dart:convert';

import 'package:noobs2pro_app/constants/api_url.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:http/http.dart' as http;

import 'articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  @override
  Future<List<Article>> fetchArticles() async {
    try {
      final url = Uri.parse(baseUrl + allPosts);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final articles = jsonDecode(response.body);

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
