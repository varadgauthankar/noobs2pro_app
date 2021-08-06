part of 'media_bloc.dart';

@immutable
abstract class MediaState {}

class MediaStateInitial extends MediaState {}

class MediaStateLoading extends MediaState {}

class MediaStateComplete extends MediaState {
  final Media media;
  MediaStateComplete(this.media);
}

class MediaStateError extends MediaState {
  final String errorMessage;
  MediaStateError(this.errorMessage);
}
