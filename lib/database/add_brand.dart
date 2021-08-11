import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddBrandService{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createBrand(String name) { 
   var id = Uuid();
   String addBrandId = id.v1();
    _firebaseFirestore.collection('brands').doc(addBrandId).set({'category' : name});
  }
}