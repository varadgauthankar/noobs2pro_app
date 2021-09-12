import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noobs2pro_app/models/article.dart';
import 'package:noobs2pro_app/services/firestore_service.dart';
import 'package:noobs2pro_app/services/hive_service.dart';

part 'article_saving_event.dart';
part 'article_saving_state.dart';

class ArticleSavingBloc extends Bloc<ArticleSavingEvent, ArticleSavingState> {
  final String firebaseUserId;
  ArticleSavingBloc({required this.firebaseUserId})
      : super(ArticleSavingInitial());

  @override
  Stream<ArticleSavingState> mapEventToState(
    ArticleSavingEvent event,
  ) async* {
    final _fireStoreService = FirestoreService(uid: firebaseUserId);
    final _hiveService = HiveService();
    // save article
    if (event is ArticleSaveEvent) {
      yield ArticleSavingLoading();
      try {
        await _hiveService.saveArticle(event.article, event.article.key);
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
        await _hiveService.unSaveArticle(event.article, event.article.key);
        _fireStoreService.unSaveArticleId(event.article.id!);
        yield ArticleUnSaved();
      } catch (e) {
        yield ArticleSavingError(e.toString());
      }
    }
  }
}
