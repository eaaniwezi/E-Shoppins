import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'categories';

  void createCategory(String name) {
    var id = Uuid();
    String addCategoryId = id.v1();
    _firebaseFirestore
        .collection('categories')
        .doc(addCategoryId)
        .set({'category': name});
  }

  Future<List<DocumentSnapshot>> getcategories() {
    return _firebaseFirestore.collection(ref).get().then((snaps) => snaps.docs);
  }
}
