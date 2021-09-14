// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:ecommerce_app/model/cart_item.dart';
import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:uuid/uuid.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class UserProvider with ChangeNotifier {
  User? _user;
  UserModel? _userModel;
  FirebaseAuth? _firebaseAuth;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  final storage = new FlutterSecureStorage();

  User? get user => _user;
  List<OrderModel> orders = [];
  Status get status => _status;
  UserModel? get userModel => _userModel;

  UserProvider.initialize() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth!.authStateChanges().listen(_onStateChanged);
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
      print("user succes");
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Fluttertoast.showToast(msg: "error from sign in");
      Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        Fluttertoast.showToast(msg: "Successfully created");
        print("CREATE USER");
        _userServices.createUser({
          'name': name,
          'email': email,
          'uid': user.user!.uid,
          'stripeId': '',
          'profilePicture': '',
          'phoneNumber': '',
          'address': '',
          'cart': []
        });
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth!.sendPasswordResetEmail(email: email);
      print("Check Your E-mail");
      Fluttertoast.showToast(msg: "Check your E-mail");
      Fluttertoast.showToast(
          msg: "A reset link has been sent to this email $email");
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      Fluttertoast.showToast(msg: "error from reset-password");
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

  // Future <bool> updatePprofile({required String name, phoneNumber, address}) async {
  //   try {
  //     _status = Status.Authenticated;
  //     notifyListeners();
  //     await _firebaseAuth!.currentUser!.updateDisplayName(name);
  //   } catch (e) {
  //    _status = Status.Authenticated;
  //     notifyListeners();
  //     Fluttertoast.showToast(msg: "error from updating profile");
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //     return false;

  Future signOut() async {
    _firebaseAuth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> removeFromCart({CartItemModel? cartItem}) async {
    print("THE PRODUCT IS: ${cartItem.toString()}");
    try {
      _userServices.removeFromCart(userId: _user!.uid, cartItem: cartItem);
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      notifyListeners();
      return false;
    }
  }

  Future<bool> addToCart(
      {required ProductModel product, String? size, String? color}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel>? cart = _userModel!.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "images": product.pictures![0],
        "productId": product.id,
        "price": product.price,
        "size": size,
        "color": color
      };
      CartItemModel item = CartItemModel.fromMap(cartItem);
      print("CART ITEMS ARE: ${cart!.toList().toString()}");
      _userServices.addToCart(userId: _user!.uid, cartItem: item);
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      notifyListeners();
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user!.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user!.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
      print("User is currently signed out");
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      print(_userModel!.cart!.length);
      print(_userModel!.cart!.length);
      _status = Status.Authenticated;
      if (_status.index == 2) {
        print("this is my state $_status");
      }
    }
    notifyListeners();
  }
}
