import 'dart:async';
import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app/services/user_services.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
}

class UserProvider with ChangeNotifier {
  FirebaseAuth? _firebaseAuth;
  User? _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel? _userModel;

  Status get status => _status;
  User? get user => _user;
  UserModel? get userModel => _userModel;

  UserProvider.initialize() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth!.authStateChanges().listen(_onStateChanged);
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

  Future signOut() async {
    _firebaseAuth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
      print("User is currently signed out");
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
