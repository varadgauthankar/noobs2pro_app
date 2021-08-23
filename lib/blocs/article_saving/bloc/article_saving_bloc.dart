import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firestore_service.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

part 'article_saving_event.dart';
part 'article_saving_state.dart';

class ArticleSavingBloc extends Bloc<ArticleSavingEvent, ArticleSavingState> {
  ArticleSavingBloc() : super(ArticleSavingInitial());

  final _fireStoreService =
      FirestoreService(uid: 'C6q6MZdWvVOCjToZwPDe7ZsNYFJ2');
  final _hiveService = HiveService();

  @override
  Stream<ArticleSavingState> mapEventToState(
    ArticleSavingEvent event,
  ) async* {
    // save article
    if (event is ArticleSaveEvent) {
      yield ArticleSavingLoading();
      try {
        _hiveService.saveArticle(event.article, event.article.key);
        _fireStoreService.saveArticleId(event.article.id!);
        yield ArticleSaved();
      } catch (e) {
        yield ArticleSavingError(e.toString());
      }
    }

    // un save article
    if (event is ArticleUnSaveEvent) {
      yield ArticleSavingLoading();
      try {
        _hiveService.unSaveArticle(event.article, event.article.key);
        _fireStoreService.unSaveArticleId(event.article.id!);
        yield ArticleUnSaved();
      } catch (e) {
        yield ArticleSavingError(e.toString());
      }
    }
  }
}
