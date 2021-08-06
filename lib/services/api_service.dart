import 'dart:convert';

import 'package:noobs2pro_app/constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:noobs2pro_app/models/models.dart';

class ApiService {
  static Future<FeaturedMedia> getArticles(int mediaId) async {
    try {
      final url = Uri.parse(baseUrl + media + mediaId.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final mediaResponse = jsonDecode(response.body);

        final FeaturedMedia mediajson =
            FeaturedMedia.fromJson(mediaResponse as Map<String, dynamic>);

        return mediajson;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<FeaturedMedia> getMedia(int mediaId) async {
    try {
      final url = Uri.parse(baseUrl + media + mediaId.toString());
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final mediaResponse = jsonDecode(response.body);

        final FeaturedMedia mediajson =
            FeaturedMedia.fromJson(mediaResponse as Map<String, dynamic>);

        return mediajson;
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
