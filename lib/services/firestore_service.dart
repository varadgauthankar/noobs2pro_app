import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _savedArticleCollection;
  String uid;

  FirestoreService({required this.uid}) {
    _firebaseFirestore = FirebaseFirestore.instance;
    _savedArticleCollection = _firebaseFirestore?.collection('saved_article');
  }

  void saveArticleId(int id) {
    _savedArticleCollection?.doc(uid).set({
      "ids": [id, id]
    });
  }

  void unSaveArticleId(int id) {
    _savedArticleCollection?.doc(uid).update({
      'ids': FieldValue.arrayRemove([id])
    });
  }

  List<int> getSavedArticleIds() {
    List<int> ids = [];
    _savedArticleCollection
        ?.doc(uid)
        .get()
        .then((value) => ids = value.get('ids') as List<int>);
    return ids;
  }
}
