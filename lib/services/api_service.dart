import 'dart:convert';

import 'package:noobs2pro_app/constants/api_url.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:noobs2pro_app/models/category.dart';

class ApiService {
  static Future<List<Article>> getAllPosts() async {
    try {
      final url = Uri.https(
        baseUrl,
        allPostsEndpoint,
        {'per_page': '100', '_embed': ''},
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final articles = jsonDecode(response.body);

        final List<Article> articlesList = [];

        for (final article in articles) {
          articlesList.add(Article.fromJson(article as Map<String, dynamic>));
        }

        return articlesList;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Article>> getPostsBySearchQuery(String query) async {
    try {
      final url = Uri.https(
        baseUrl,
        allPostsEndpoint,
        {'search': query, 'per_page': '20', '_embed': ''},
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final articles = jsonDecode(response.body);

        final List<Article> articlesList = [];

        for (final article in articles) {
          articlesList.add(Article.fromJson(article as Map<String, dynamic>));
        }

        return articlesList;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Article>> getPostsByCategory(int id) async {
    try {
      final url = Uri.parse(baseUrl + getPostsByCategoryId + id.toString());
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final articles = jsonDecode(response.body);

        final List<Article> articlesList = [];

        for (final article in articles) {
          articlesList.add(Article.fromJson(article as Map<String, dynamic>));
        }
        return articlesList;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Category>> getAllCategories() async {
    try {
      final url = Uri.https(baseUrl, categories, perPage100);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final categories = jsonDecode(response.body);

        final List<Category> categoryList = [];

        for (final category in categories) {
          categoryList.add(Category.fromJson(category as Map<String, dynamic>));
        }
        return categoryList;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Category> getCategoryById(int id) async {
    try {
      final url = Uri.https(baseUrl, '$categories/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final categoryJson = jsonDecode(response.body);

        final Category category =
            Category.fromJson(categoryJson as Map<String, dynamic>);
        return category;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
