import 'dart:convert';

import 'package:noobs2pro_app/blocs/media_fetch/repository/media_repository.dart';
import 'package:noobs2pro_app/constants/api_url.dart';
import 'package:noobs2pro_app/models/media.dart';
import 'package:http/http.dart' as http;

class MediaRepositoryImpl implements MediaReposiotry {
  @override
  Future<Media> fetchMedia(int mediaId) async {
    try {
      final url = Uri.parse(baseUrl + getMedia + mediaId.toString());
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
