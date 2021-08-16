import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_app/pages/users_pages/welcome_screen.dart';

import 'pages/admin_pages/admin_add_product_screen.dart';

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
                  // primarySwatch: Colors.red,
                  ),
              home: AdminAddProductScreen(),
              // home:  AdminHomeScreen(),
              // home: WelcomeScreen(),
              // home: HomePage(),
            );
          }
          return Container();
        });
  }
}
