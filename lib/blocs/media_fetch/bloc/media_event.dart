part of 'media_bloc.dart';

abstract class MediaEvent {}

class FetchMediaEvent extends MediaEvent {
  final int mediaId;
  FetchMediaEvent(this.mediaId);
}
