part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesFetchLoading extends ArticlesState {}

class ArticlesFetchComplete extends ArticlesState {
  final List<Article> articles;
  ArticlesFetchComplete(this.articles);
}

class ArticlesFetchError extends ArticlesState {}
