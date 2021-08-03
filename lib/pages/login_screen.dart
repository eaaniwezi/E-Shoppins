import 'package:ecommerce_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late final User user;
  // late final O

  late SharedPreferences preferences;
  late bool loading;
  late bool isLogedin;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if (isLogedin == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
    // ignore: await_only_futures
    user = await firebaseAuth.currentUser!;

    // ignore: unnecessary_null_comparison
    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;

      if (documents.length == 0) {
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "email": user.email,
          "profilePicture": user.photoURL,
          "phoneNumber": user.phoneNumber,
        });

        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName.toString());
        await preferences.setString("email", user.email.toString());
        await preferences.setString("profilePicture", user.photoURL.toString());
        await preferences.setString("phoneNumber", user.phoneNumber.toString());
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("email", documents[0]['email']);
        await preferences.setString(
            "photoURL", documents[0]['photoURL']);
        await preferences.setString(
            "phoneNumber", documents[0]['phoneNumber']);
      }
      Fluttertoast.showToast(msg: "Succesful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            handleSignIn();
          },
          child: Container(
            color: Colors.red,
            child: Text(
              "Google",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
