import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cart_item.dart';

class UserModel {
  final String? uid, name, email, stripeId;
  List<CartItemModel>? cart;

  UserModel({
    this.cart,
    this.uid,
    this.name,
    this.email,
    this.stripeId,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    //
    List<CartItemModel> _convertedCartItems(List cart) {
      List<CartItemModel> convertedCart = [];
      for (Map cartItem in cart) {
        convertedCart.add(CartItemModel.fromMap(cartItem));
      }
      return convertedCart;
    }

    return UserModel(
      uid: snapshot["uid"],
      name: snapshot["name"],
      email: snapshot["email"],
      stripeId: snapshot["stripeId"] ?? "",
      cart: _convertedCartItems(snapshot["cart"] ?? []),
    );
  }
}
