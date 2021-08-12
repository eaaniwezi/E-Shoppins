import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class CategoryService {
  // static CategoryService _instance = CategoryService();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'categories';
  late Future<QuerySnapshot> searchResultsFuture;

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

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      _firebaseFirestore
          .collection(ref)
          .where('category', isEqualTo: suggestion)
          .get()
          .then((snaps) => snaps.docs);

  handleSearchCategories(String query) {
    Future<QuerySnapshot<Map<String, dynamic>>> categories = _firebaseFirestore
        .collection(ref)
        .where("category", isGreaterThanOrEqualTo: query)
        .where("category", isGreaterThanOrEqualTo: query + 'z')
        .where('category', isEqualTo: query)
        .get();
    searchResultsFuture = categories;
  }
}
