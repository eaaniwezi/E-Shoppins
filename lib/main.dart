import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_app/pages/users_pages/welcome_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:ecommerce_app/providers/users_providers/app_providers.dart';
import 'package:ecommerce_app/providers/users_providers/product_providers.dart';
import 'package:ecommerce_app/providers/admin_providers/products_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
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
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: UserProvider.initialize()),
                ChangeNotifierProvider.value(
                    value: UsersProductProvider.initialize()),
                ChangeNotifierProvider.value(value: AppProvider()),
                ChangeNotifierProvider.value(value: AdminProductProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'E-Shoppins',
                theme: ThemeData(
                    // primarySwatch: Colors.red,
                    ),
                // home: AdminAddProductScreen(),
                // home:  AdminHomeScreen(),
                home: WelcomeScreen(),
                // home: CartMainScreen(),
                // home: ForgotPasswordScreen(),
                // home: HomePage(),
              ),
            );
          }
          return Container();
        });
  }
}
