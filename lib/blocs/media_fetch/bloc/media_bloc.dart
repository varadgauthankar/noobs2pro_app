import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/media_fetch/repository/media_repository.dart';
import 'package:noobs2pro_app/models/media.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaReposiotry _mediaReposiotry;

  MediaBloc(this._mediaReposiotry) : super(MediaStateInitial());

  @override
  Stream<MediaState> mapEventToState(MediaEvent event) async* {
    if (event is FetchMediaEvent) {
      yield MediaStateInitial();
      try {
        final Media media = await _mediaReposiotry.fetchMedia(event.mediaId);
        yield MediaStateComplete(media);
      } on SocketException {
        yield MediaStateError('No internet');
      } on HttpException {
        yield MediaStateError('No Service found');
      } on FormatException {
        yield MediaStateError('invalid response format');
      } catch (e) {
        yield MediaStateError(e.toString());
      }
    }
  }
}
