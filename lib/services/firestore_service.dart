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
    _savedArticleCollection?.doc(uid).set(
      {
        "ids": FieldValue.arrayUnion([id])
      },
      SetOptions(merge: true),
    );
  }

  void unSaveArticleId(int id) {
    _savedArticleCollection?.doc(uid).update({
      'ids': FieldValue.arrayRemove([id])
    });
  }

  Future getSavedArticleIds() async {
    final doc = await _savedArticleCollection?.doc(uid).get();
    final dynamic value;
    if (doc!.exists) {
      value = await doc.get('ids');
    } else {
      value = [];
    }

    // .then((value) => ids = value.get('ids') as List<int>);

    return value;
  }
}
