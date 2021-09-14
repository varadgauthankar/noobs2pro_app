import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noobs2pro_app/blocs/articles_fetch/repository/articles_repository.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firestore_service.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository _articlesRepository;
  final String firebaseUserId;

  ArticlesBloc(this._articlesRepository, {required this.firebaseUserId})
      : super(ArticlesInitial());

  @override
  Stream<ArticlesState> mapEventToState(
    ArticlesEvent event,
  ) async* {
    final _firestoreService = FirestoreService(uid: firebaseUserId);
    // get all articles
    if (event is FetchArticlesEvent) {
      yield ArticlesFetchLoading();
      try {
        final List<Article> articles =
            await _articlesRepository.fetchArticles(_firestoreService);
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
    // get article by query
    else if (event is FetchArticleByQueryEvent) {
      yield ArticlesFetchLoading();
      try {
        final List<Article> articles =
            await _articlesRepository.fetchArticlesByQuery(
          _firestoreService,
          query: event.query,
        );
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

    // get article by category
    else if (event is FetchCategoryArticlesEvent) {
      yield ArticlesFetchLoading();
      try {
        final List<Article> articles = await _articlesRepository
            .fetchArticlesByCategory(_firestoreService, event.id);
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

    // explore articles
    else if (event is FetchExploreArticlesEvent) {
      yield ArticlesFetchLoading();
      try {
        final List<Article> articles =
            await _articlesRepository.fetchExploreArticles(_firestoreService);
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
