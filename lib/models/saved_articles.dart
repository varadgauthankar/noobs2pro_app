class SavedArticle {
  List<int> ids;

  SavedArticle(this.ids);

  void saveArticle(int id) {
    ids.add(id);
  }

  void removeSavedArticle(int id) {
    ids.remove(id);
  }
}
