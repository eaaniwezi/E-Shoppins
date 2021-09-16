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
  static const ISADMIN = 'isAdmin';

  String? _name;
  String? _email;
  String? _profilePicture;
  String? _phoneNumber;
  String? _address;
  String? _id;
  String? _stripeId;
  num _priceSum = 0;
  bool _isAdmin = false;

//  getters
  String? get name => _name;
  String? get email => _email;
  String? get profilePicture => _profilePicture;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get id => _id;
  bool? get isAdmin => _isAdmin;

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
    _isAdmin = snapshot[ISADMIN];
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
