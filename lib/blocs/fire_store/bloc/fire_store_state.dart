part of 'fire_store_bloc.dart';

abstract class FirestoreState {}

class FirestoreStateInitial extends FirestoreState {}

class FirestoreStateLoading extends FirestoreState {}

class FirestoreStateComplete extends FirestoreState {}

class FirestoreGetSavedArticleStateComplete extends FirestoreState {
  final List<int> ids;
  FirestoreGetSavedArticleStateComplete(this.ids);
}

class FirestoreStateError extends FirestoreState {
  String error;
  FirestoreStateError(this.error);
}
