import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:ecommerce_app/database/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _showPassword = false;
  bool _showPassword2 = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  var confirmPass;
  bool circular = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _globalkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "       Choose you,\nChoose your Style!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25),
                  child: Column(
                    children: [
                      usernameTextField(),
                      SizedBox(height: 10.0),
                      emailTextField(),
                      SizedBox(height: 10.0),
                      passwordTextField(),
                      SizedBox(height: 20.0),
                      confirmPasswordTextField(),
                      SizedBox(height: 50.0),
                      registerButton(),
                      SizedBox(height: 20.0),
                      backButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return Container(
      width: 200,
      height: 45.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 1.0),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Re-Enter New Password";
        } else if (value.length < 8) {
          return "Password must be atleast 8 characters long";
        } else if (value != confirmPass) {
          return "Password must be same as above";
        } else {
          return null;
        }
      },
      controller: _passwordController2,
      obscureText: !_showPassword2,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Style.Colors.secondColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility2();
          },
          child: Icon(
            _showPassword2 ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Confirm Password',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Style.Colors.secondColor,
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          registerUser();
        } catch (e) {
          print(e);
          _usernameController.text = "";
          _passwordController.text = "";
          _passwordController2.text = "";
          _emailController.text = "";
        }
      },
      child: Container(
        width: 200,
        height: 45.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          // shadowColor: Colors.greenAccent,
          color: Style.Colors.secondColor,
          elevation: 7.0,
          child: Center(
            child: circular
                ? CircularProgressIndicator()
                : Text(
                    'REGISTER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_showPassword,
      validator: (value) {
        confirmPass = value;
        if (value!.isEmpty) {
          return "Please Enter New Password";
        } else if (value.length < 8) {
          return "Password must be atleast 8 characters long";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Style.Colors.secondColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility();
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Style.Colors.secondColor,
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        Pattern pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = new RegExp(pattern.toString());
        // ignore: unnecessary_null_comparison
        if (!regex.hasMatch(value!) || value == null)
          return 'Enter a valid email address';
        if (value.isEmpty) return "Email can't be empty";
        if (!value.contains("@")) return "Invalid Email";
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: Style.Colors.secondColor,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Style.Colors.secondColor,
          ),
        ),
      ),
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Username can't be empty";
        return null;
      },
      controller: _usernameController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Style.Colors.secondColor,
        ),
        labelText: 'Username',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Style.Colors.secondColor,
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Style.Colors.secondColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Future registerUser() async {
    FormState? formState = _globalkey.currentState;

    if (formState!.validate()) {
      formState.reset();
      print("user in");
      // ignore: await_only_futures
      User? user = await firebaseAuth.currentUser;
      // ignore: unnecessary_null_comparison
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((user) => {
                  _userServices.createUser({
                    "userId": user.user!.uid,
                    "username": _usernameController.text,
                    "email": _emailController.text,
                  })
                })
            .catchError((err) => {
                  print(err.toString()),
                  Fluttertoast.showToast(msg: err.toString()),
                });
print("userCreated");
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      setState(() {
        circular = false;
      });
      return Fluttertoast.showToast(msg: "Failed in creating an account");
    }
  }
}
