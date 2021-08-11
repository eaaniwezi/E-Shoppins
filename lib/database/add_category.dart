import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddCategoryService{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createCategory(String name) { 
   var id = Uuid();
   String addCategoryId = id.v1();
    _firebaseFirestore.collection('categories').doc(addCategoryId).set({'category' : name});
  }
}