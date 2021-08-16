abstract class FirestoreRepository {
  Future<List<int>> getSavedArticleId();
  Future<void> deleteArticleId(int id);
  Future<void> inserteArticleId(int id);
}
