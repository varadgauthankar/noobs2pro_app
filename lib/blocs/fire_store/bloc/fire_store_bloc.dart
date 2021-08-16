import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobs2pro_app/blocs/fire_store/repository/fire_store_repository_impl.dart';

part 'fire_store_state.dart';
part 'fire_store_event.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreBloc() : super(FirestoreStateInitial());
  final _repository = FirestoreRepositoryImpl();

  @override
  Stream<FirestoreState> mapEventToState(FirestoreEvent event) async* {
    if (event is FirestoreSaveArticleId) {
      yield FirestoreStateLoading();
      try {
        _repository.inserteArticleId(event.id);
        yield FirestoreStateComplete();
      } catch (e) {
        yield FirestoreStateError(e.toString());
      }
    } else if (event is FirestoreDeleteArticleId) {
      try {
        _repository.deleteArticleId(event.id);
        yield FirestoreStateComplete();
      } catch (e) {
        yield FirestoreStateError(e.toString());
      }
    } else if (event is FirestoreGetArticleId) {
      try {
        final List<int> ids = await _repository.getSavedArticleId();
        yield FirestoreGetSavedArticleStateComplete(ids);
      } catch (e) {
        yield FirestoreStateError(e.toString());
      }
    }
  }
}
