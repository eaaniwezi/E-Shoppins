import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'brands';

  void createBrand(String name) {
    var id = Uuid();
    String addBrandId = id.v1();
    _firebaseFirestore.collection(ref).doc(addBrandId).set({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firebaseFirestore.collection(ref).get().then((snaps) => snaps.docs);
  }
}
