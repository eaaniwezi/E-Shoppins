import 'package:ecommerce_app/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_app/model/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String collection = "users";

  createUser(Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc(data["uid"])
          .set(data);
      print('Successfully created');
      Fluttertoast.showToast(msg: "Successfully created");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // updateUsers(Map<String, dynamic> data)  {
  //   try {
  //      _firebaseFirestore
  //         .collection(collection)
  //         .doc(data["uid"])
  //         .update(data);
  //     print("successfully updated");
  //     Fluttertoast.showToast(msg: "Successfully updated");
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<UserModel> getUserById(String id) => _firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((doc) => UserModel.fromSnapshot(doc));

  void addToCart({String? userId, CartItemModel? cartItem}) {
    _firebaseFirestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem!.toMap()])
    });
  }

  void removeFromCart({String? userId, CartItemModel? cartItem}) {
    _firebaseFirestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem!.toMap()])
    });
  }
}
