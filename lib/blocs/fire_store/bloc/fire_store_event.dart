part of 'fire_store_bloc.dart';

abstract class FirestoreEvent {}

class FirestoreSaveArticleId extends FirestoreEvent {
  final int id;
  FirestoreSaveArticleId(this.id);
}

class FirestoreDeleteArticleId extends FirestoreEvent {
  final int id;
  FirestoreDeleteArticleId(this.id);
}

class FirestoreGetArticleId extends FirestoreEvent {}
