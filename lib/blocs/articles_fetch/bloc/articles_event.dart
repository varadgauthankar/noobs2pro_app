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

// category articles
class FetchCategoryArticlesEvent extends ArticlesEvent {
  final int id;
  FetchCategoryArticlesEvent(this.id);
}

// explore articles
class FetchExploreArticlesEvent extends ArticlesEvent {}
