import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id, description, userId, status;
  final int? createdAt, totalPrice;
  List? cart;

  OrderModel({
    this.id,
    this.description,
    this.userId,
    this.status,
    this.createdAt,
    this.totalPrice,
    this.cart,
  });

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    return OrderModel(
      id: snapshot['id'],
      description: snapshot['description'],
      userId: snapshot['userId'],
      status: snapshot['status'],
      createdAt: snapshot['createdAt'],
      totalPrice: snapshot['totalPrice'],
      cart: snapshot['cart'],
    );
  }
}
