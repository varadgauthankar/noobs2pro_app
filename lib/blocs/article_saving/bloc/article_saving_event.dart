part of 'article_saving_bloc.dart';

@immutable
abstract class ArticleSavingEvent {}

class ArticleSaveEvent extends ArticleSavingEvent {
  Article article;
  ArticleSaveEvent(this.article);
}

class ArticleUnSaveEvent extends ArticleSavingEvent {
  Article article;
  ArticleUnSaveEvent(this.article);
}
