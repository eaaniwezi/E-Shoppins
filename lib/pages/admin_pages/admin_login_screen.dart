// import 'package:ecommerce_app/pages/users_pages/forgot_%20password_screen.dart';
// import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_app/home_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ecommerce_app/style/theme.dart' as Style;
// import 'package:ecommerce_app/pages/admin_pages/admin_home_screen.dart';
// import 'package:ecommerce_app/pages/users_pages/create_account_screen.dart';
// import 'package:provider/provider.dart';

// class AdminLoginScreen extends StatefulWidget {
//   const AdminLoginScreen({Key? key}) : super(key: key);

//   @override
//   _AdminLoginScreenState createState() => _AdminLoginScreenState();
// }

// class _AdminLoginScreenState extends State<AdminLoginScreen> {
//   bool _showPassword = false;
//   void _togglevisibility() {
//     setState(() {
//       _showPassword = !_showPassword;
//     });
//   }

//   bool circular = false;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _globalkey = GlobalKey<FormState>();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: _appBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Form(
//             key: _globalkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.04),
//                 Center(
//                   child: Text(
//                     "Glad you're back!",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 25),
//                   child: Column(
//                     children: [
//                       emailTextField(),
//                       passwordTextField(),
//                       SizedBox(height: 5.0),
//                       forgetPassword(),
//                       SizedBox(height: 25.0),
//                       loginButton(),
//                       SizedBox(height: 20.0),
//                       Text(
//                         "OR CONTINUE WITH",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Montserrat',
//                         ),
//                       ),
//                       SizedBox(height: 20.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           googleLogin(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 createAccount(),
//                 SizedBox(height: 15.0),
//                 isAdmin(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget isAdmin() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'Is Admin? ',
//           style: TextStyle(fontFamily: 'Montserrat'),
//         ),
//         SizedBox(width: 5.0),
//         InkWell(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => AdminHomeScreen()));
//           },
//           child: Text(
//             'Click to login',
//             style: TextStyle(
//                 color: Style.Colors.secondColor,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline),
//           ),
//         )
//       ],
//     );
//   }

//   Widget createAccount() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'Don\'t have an account? ',
//           style: TextStyle(fontFamily: 'Montserrat'),
//         ),
//         SizedBox(width: 5.0),
//         InkWell(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => CreateAccountScreen()));
//           },
//           child: Text(
//             'Create One',
//             style: TextStyle(
//                 color: Style.Colors.secondColor,
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline),
//           ),
//         )
//       ],
//     );
//   }

//   Widget googleLogin() {
//     return GestureDetector(
//       onTap: () {
//         Fluttertoast.showToast(msg: "Sorry!! Not working at the moment");
//       },
//       child: Container(
//         width: 120,
//         height: 45.0,
//         color: Colors.transparent,
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(
//                   color: Colors.black, style: BorderStyle.solid, width: 1.0),
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(20.0)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Center(
//                 child: ImageIcon(
//                   AssetImage(
//                     'images/image/google.png',
//                   ),
//                   color: Colors.red,
//                 ),
//               ),
//               SizedBox(width: 10.0),
//               Center(
//                 child: Text(
//                   'Google',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Montserrat',
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget loginButton() {
//     final user = Provider.of<UserProvider>(context);
//     return GestureDetector(
//       onTap: () async {
//         setState(() {
//           circular = true;
//         });
//         try {
//           if (_globalkey.currentState!.validate()) {
//             if (!await user.signIn(_email.text, _password.text)) {
//               Fluttertoast.showToast(msg: "Error sign in");
//               setState(() {
//                 circular = false;
//               });
//             } else {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomePage()),
//                   (route) => false);
//             }
//           } else {
//             setState(() {
//               circular = false;
//             });
//             Fluttertoast.showToast(msg: "Validator Errors");
//           }
//         } catch (e) {
//           print(e.toString());
//           Fluttertoast.showToast(msg: e.toString());
//           setState(() {
//             circular = false;
//           });
//           Fluttertoast.showToast(msg: "Can't login");
//         }
//       },
//       child: Container(
//         width: 200,
//         height: 45.0,
//         child: Material(
//           borderRadius: BorderRadius.circular(20.0),
//           // shadowColor: Colors.greenAccent,
//           color: Style.Colors.secondColor,
//           elevation: 7.0,
//           child: Center(
//             child: circular
//                 ? CircularProgressIndicator(color: Style.Colors.greenColor)
//                 : Text(
//                     'LOGIN',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Montserrat'),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget forgetPassword() {
//     return Container(
//       alignment: Alignment(1.0, 0.0),
//       padding: EdgeInsets.only(top: 15.0, left: 20.0),
//       child: InkWell(
//         onTap: () {
//           Fluttertoast.showToast(
//               msg: "Why did you forget your password, Ode!!");
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
//         },
//         child: Text(
//           'Forgot Password',
//           style: TextStyle(
//             color: Style.Colors.secondColor,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Montserrat',
//             decoration: TextDecoration.underline,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget passwordTextField() {
//     return TextFormField(
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "Please Enter New Password";
//         } else if (value.length < 8) {
//           return "Password must be atleast 8 characters long";
//         } else {
//           return null;
//         }
//       },
//       controller: _password,
//       obscureText: !_showPassword,
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           Icons.lock,
//           color: Style.Colors.secondColor,
//         ),
//         suffixIcon: GestureDetector(
//           onTap: () {
//             _togglevisibility();
//           },
//           child: Icon(
//             _showPassword ? Icons.visibility : Icons.visibility_off,
//             color: Colors.black,
//           ),
//         ),
//         labelText: 'Password',
//         labelStyle: TextStyle(
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.bold,
//             color: Colors.grey),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Style.Colors.secondColor,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget emailTextField() {
//     return TextFormField(
//       validator: (value) {
//         Pattern pattern =
//             r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//             r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//             r"{0,253}[a-zA-Z0-9])?)*$";
//         RegExp regex = new RegExp(pattern.toString());
//         // ignore: unnecessary_null_comparison
//         if (!regex.hasMatch(value!) || value == null)
//           return 'Enter a valid email address';
//         if (value.isEmpty) return "Email can't be empty";
//         if (!value.contains("@")) return "Invalid Email";
//         return null;
//       },
//       controller: _email,
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           Icons.mail_outline_rounded,
//           color: Style.Colors.secondColor,
//         ),
//         labelText: 'Email',
//         labelStyle: TextStyle(
//           fontFamily: 'Montserrat',
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: Style.Colors.secondColor,
//           ),
//         ),
//       ),
//     );
//   }

//   _appBar() {
//     return AppBar(
//       elevation: 0,
//       centerTitle: true,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: Style.Colors.secondColor,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       backgroundColor: Colors.transparent,
//       title: Text(
//         "Sign In",
//         style: TextStyle(
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }
