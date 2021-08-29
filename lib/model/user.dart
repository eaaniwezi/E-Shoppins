// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_app/model/cart_item.dart';

// class UserModel {
//   final String? uid, name, email, stripeId;
//   List<CartItemModel>? cart;

//   UserModel({
//     this.cart,
//     this.uid,
//     this.name,
//     this.email,
//     this.stripeId,
//   });

//   factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return UserModel(
//       uid: snapshot["uid"],
//       name: snapshot["name"],
//       email: snapshot["email"],
//       stripeId: snapshot["stripeId"] ?? "",
//         cart: _convertedCartItems(snapshot["cart"]?? []),
//       // cart: _convertedCartItems(snapshot["cart"] ?? []),

//     );
//   }

//   List<CartItemModel> _convertedCartItems(List cart) {
//     List<CartItemModel> convertedCart = [];
//     for (Map cartItem in cart) {
//       convertedCart.add(CartItemModel.fromMap(cartItem));
//     }
//     return convertedCart;
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";


  String? _name;
  String? _email;
  String? _id;
  String? _stripeId;


//  getters
  String? get name => _name;

  String? get email => _email;

  String? get id => _id;

  String? get stripeId => _stripeId;

  // public variables
  List<CartItemModel>? cart;



  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _email = snapshot[EMAIL];
    _id = snapshot[ID];
    _stripeId = snapshot[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot[CART]?? []);
  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  // int getTotalPrice({List cart}){
  //   if(cart == null){
  //     return 0;
  //   }
  //   for(Map cartItem in cart){
  //     _priceSum += cartItem["price"];
  //   }

  //   int total = _priceSum;
  //   return total;
  // }
}
