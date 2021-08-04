part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class FetchArticlesEvent extends ArticlesEvent {
  FetchArticlesEvent();
}
