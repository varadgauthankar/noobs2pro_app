import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore? _firebaseFirestore;
  CollectionReference? _savedArticleCollection;

  FirestoreService() {
    _firebaseFirestore = FirebaseFirestore.instance;
    _savedArticleCollection = _firebaseFirestore?.collection('saved_article');
  }

  void saveArticleId(int id) {
    _savedArticleCollection?.add({'id': 3455});
  }

  void unSaveArticleId(int id) {
    // _savedArticleCollection.('collectionPath').({'f': 'f'});
  }
}
