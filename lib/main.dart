import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/pages/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Container(
              child: Text(
                "has error",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-Shoppins',
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              home: LoginScreen(),
            );
          }
          return Container();
        });
  }
}
