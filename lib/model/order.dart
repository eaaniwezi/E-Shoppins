import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id, description, userId, status;
  final int? createdAt, total;
  List? cart;

  OrderModel({
    this.id,
    this.description,
    this.userId,
    this.status,
    this.createdAt,
    this.total,
    this.cart,
  });

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    return OrderModel(
      id: snapshot['id'],
      description: snapshot['description'],
      userId: snapshot['userId'],
      status: snapshot['status'],
      createdAt: snapshot['createdAt'],
      total: snapshot['total'],
      cart: snapshot['cart'],
    );
  }
}
