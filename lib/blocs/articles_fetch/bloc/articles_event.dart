part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class FetchArticlesEvent extends ArticlesEvent {
  FetchArticlesEvent();
}

//search article
class FetchArticleByQueryEvent extends ArticlesEvent {
  final String query;
  FetchArticleByQueryEvent(this.query);
}
