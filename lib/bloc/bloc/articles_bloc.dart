import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noobs2pro_app/bloc/repository/articles_repository.dart';
import 'package:noobs2pro_app/models/article.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository _articlesRepository;

  ArticlesBloc(this._articlesRepository) : super(ArticlesInitial());

  @override
  Stream<ArticlesState> mapEventToState(
    ArticlesEvent event,
  ) async* {
    if (event is FetchArticlesEvent) {
      yield ArticlesFetchLoading();
      try {
        final List<Article> articles =
            await _articlesRepository.fetchArticles();
        yield ArticlesFetchComplete(articles);
      } on SocketException {
        yield ArticlesFetchError('No internet');
      } on HttpException {
        yield ArticlesFetchError('No Service found');
      } on FormatException {
        yield ArticlesFetchError('invalid response format');
      } catch (e) {
        yield ArticlesFetchError(e.toString());
      }
    }
  }
}
