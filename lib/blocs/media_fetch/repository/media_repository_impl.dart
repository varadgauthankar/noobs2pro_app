import 'package:noobs2pro_app/blocs/media_fetch/repository/media_repository.dart';
import 'package:noobs2pro_app/models/media.dart';
import 'package:noobs2pro_app/services/api_service.dart';

class MediaRepositoryImpl implements MediaReposiotry {
  @override
  Future<Media> fetchMedia(int mediaId) async {
    return ApiService.getMediaById(mediaId);
  }
}
