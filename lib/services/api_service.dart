import 'dart:convert';

import 'package:noobs2pro_app/constants/api_url.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:noobs2pro_app/models/media.dart';

class ApiService {
  static Future<List<Article>> getAllPosts() async {
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
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Media> getMediaById(int id) async {
    try {
      final url = Uri.parse(baseUrl + getMedia + id.toString());
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final mediaJson = jsonDecode(response.body);

        final Media media = Media.fromJson(mediaJson as Map<String, dynamic>);
        return media;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
