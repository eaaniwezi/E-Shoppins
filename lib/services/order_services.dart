import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cart_item.dart';
import 'package:ecommerce_app/model/order.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createOrder(
      {String? userId,
      id,
      description,
      status,
      List<CartItemModel>? cart,
      int? totalPrice}) {
    List<Map> convertedCart = [];

    for (CartItemModel item in cart!) {
      convertedCart.add(item.toMap());
    }

    _firebaseFirestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "totalPrice": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status,
    });
  }

  Future<List<OrderModel>> getUserOrders({String? userId}) async =>
      _firebaseFirestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
