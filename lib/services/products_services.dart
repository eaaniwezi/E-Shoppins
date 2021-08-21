import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product.dart';

class UsersProductServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String colllection = "products";

  Future<List<ProductModel>> getFeaturedProducts() => _firebaseFirestore
          .collection(colllection)
          .where('featured', isEqualTo: true)
          .get()
          .then((snaps) {
        List<ProductModel> featuredProducts = [];
        snaps.docs.map((snapshot) =>
            featuredProducts.add(ProductModel.fromDocument(snapshot)));
        return featuredProducts;
      });

  Future<List<ProductModel>> getProducts() async =>
      _firebaseFirestore.collection(colllection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromDocument(product));
        }
        return products;
      });
}
