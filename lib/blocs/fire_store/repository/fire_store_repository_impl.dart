import 'fire_store_repository.dart';

class FirestoreRepositoryImpl extends FirestoreRepository {
  @override
  Future<void> inserteArticleId(int id) async {
    // TODO: implement inserteArticleId
  }

  @override
  Future deleteArticleId(int id) async {
    //TODO: impliment delete id in firestore
  }

  @override
  Future<List<int>> getSavedArticleId() async {
    await Future.delayed(const Duration(microseconds: 100));
    return [1, 2, 34, 5];

    //TODO: impliment get id in firestore
  }
}
