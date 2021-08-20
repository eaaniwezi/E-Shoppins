import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = 'products';

   void uploadProduct(Map<String, dynamic> data) {
    var id = Uuid();
    String productId = id.v1();
    data["id"] = productId;
    _firebaseFirestore.collection(ref).doc(productId).set(data);
  }

  // void uploadProduct({required String productName, brand, category, required int quantity,  required List sizes, images, required double price}) {
  //   var id = Uuid();
  //   String productId = id.v1();

  //   _firebaseFirestore.collection(ref).doc(productId).set({
  //     'name' : productName,
  //     'id': productId,
  //     'brand': brand,
  //     'category': category,
  //     'quantity': quantity,
  //     'sizes': sizes,
  //     'images': images,
  //     'price' : price
  //   });
  // }
}
