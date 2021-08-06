import 'package:noobs2pro_app/models/media.dart';

abstract class MediaReposiotry {
  Future<Media> fetchMedia(int mediaId);
}
