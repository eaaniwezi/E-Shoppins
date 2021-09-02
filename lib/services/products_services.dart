
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
         for (DocumentSnapshot featuredProduct in snaps.docs) {
          featuredProducts.add(ProductModel.fromSnapshot(featuredProduct));
        }
        return featuredProducts;
      });

  Future<List<ProductModel>> getProducts() async =>
      _firebaseFirestore.collection(colllection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String? productName}) {
    String searchKey = productName![0].toUpperCase() + productName.substring(1);
    return _firebaseFirestore
        .collection(colllection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }
}
