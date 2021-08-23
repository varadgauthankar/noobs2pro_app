part of 'article_saving_bloc.dart';

@immutable
abstract class ArticleSavingState {}

class ArticleSavingInitial extends ArticleSavingState {}

class ArticleSavingLoading extends ArticleSavingState {}

class ArticleSavingError extends ArticleSavingState {
  final String error;
  ArticleSavingError(this.error);
}

class ArticleSaved extends ArticleSavingState {}

class ArticleUnSaved extends ArticleSavingState {}
