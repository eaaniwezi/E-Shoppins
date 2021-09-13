// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_app/model/cart_item.dart';

// class UserModel {
//   final String? uid, name, email, stripeId;
//   final int? priceSum;
//   List<CartItemModel>? cart;

//   UserModel({
//     this.priceSum,
//     this.cart,
//     this.uid,
//     this.name,
//     this.email,
//     this.stripeId,
//   });

//   factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     //
//     List<CartItemModel> _convertedCartItems(List cart) {
//       List<CartItemModel> convertedCart = [];
//       for (Map cartItem in cart) {
//         convertedCart.add(CartItemModel.fromMap(cartItem));
//       }
//       return convertedCart;
//     }

//     return UserModel(
//       uid: snapshot["uid"],
//       name: snapshot["name"],
//       email: snapshot["email"],
//       stripeId: snapshot["stripeId"] ?? "",
//       cart: _convertedCartItems(snapshot["cart"] ?? []),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PROFILEPICTURE = "profilePicture";
  static const PHONENUMBER = "phoneNumber";
  static const ADDRESS = "address";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String? _name;
  String? _email;
  String? _profilePicture;
  String? _phoneNumber;
  String? _address;
  String? _id;
  String? _stripeId;
  num _priceSum = 0;

//  getters
  String? get name => _name;
  String? get email => _email;
  String? get profilePicture => _profilePicture;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get id => _id;

  String? get stripeId => _stripeId;

  // public variables
  List<CartItemModel>? cart;
  num? totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _email = snapshot[EMAIL];
    _profilePicture = snapshot[PROFILEPICTURE];
    _phoneNumber = snapshot[PHONENUMBER];
    _address = snapshot[ADDRESS];
    _id = snapshot[ID];
    _stripeId = snapshot[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot[CART] ?? []);
    totalCartPrice =
        (snapshot[CART] == null ? 0 : getTotalPrice(cart: snapshot[CART]))!;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  num? getTotalPrice({List? cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"];
    }

    num? total = _priceSum;
    return total;
  }
}
