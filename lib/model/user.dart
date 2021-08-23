import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid, name, email, stripeId;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.stripeId,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot["uid"],
      name: snapshot["name"],
      email: snapshot["email"],
      stripeId: snapshot["stripeId"] ?? "",
    );
  }
}
