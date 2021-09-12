import 'package:ecommerce_app/pages/users_pages/profile_screen.dart';
import 'package:ecommerce_app/pages/users_pages/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/pages/users_pages/order_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class DrawerChildren extends StatelessWidget {
  const DrawerChildren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    final userProvider = Provider.of<UserProvider>(context);
    return new ListView(
      children: [
        new UserAccountsDrawerHeader(
          accountName: Text(
            userProvider.userModel?.name ?? "username lading...",
          ),
          accountEmail: Text(
            userProvider.userModel?.email ?? "email loading...",
          ),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Style.Colors.secondColor,
              ),
            ),
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () async {
              await userProvider.getOrders();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderScreen()));
            },
            child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_cart_rounded,
                    color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Categories"),
                leading:
                    Icon(Icons.dashboard, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Favorites"),
                leading:
                    Icon(Icons.favorite, color: Style.Colors.secondColor))),
        Divider(),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Settings"),
                leading:
                    Icon(Icons.settings, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Languages"),
                leading:
                    Icon(Icons.language, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {
              googleSignIn.signOut().then((value) => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen())),
                  });
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              });
            },
            child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout, color: Style.Colors.secondColor))),
      ],
    );
  }
}
