import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String collection = "users";

  createUser(Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc((data["uid"]))
          .set(data);
      print('Successfully created');
      Fluttertoast.showToast(msg: "Successfully created");
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<UserModel> getUserById(String id) => _firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((doc) => UserModel.fromSnapshot(doc));
}
