import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/pages/users_pages/login_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool circular = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Center(
                child: Text(
                  "Please  don't forget your password again!",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: Column(
                  children: [
                    emailTextField(),
                    SizedBox(height: 25.0),
                    resetButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resetButton() {
    final user = Provider.of<UserProvider>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          if (_globalkey.currentState!.validate()) {
            if (!await user.resetPassword(_email.text)) {
              Fluttertoast.showToast(msg: "Error sending reset link");
            }
            setState(() {
              circular = false;
              _email.text = "";
            });
          } else {
            setState(() {
              circular = false;
              _email.text = "";
            });
            Fluttertoast.showToast(msg: "Validator Errors");
          }
        } catch (e) {}
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
                ? CircularProgressIndicator(color: Style.Colors.greenColor)
                : Text(
                    'RESET PASSWORD',
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

  Widget emailTextField() {
    return TextFormField(
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
      controller: _email,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: Style.Colors.secondColor,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
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
        "Forgot Password",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
