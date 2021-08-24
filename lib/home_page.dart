import 'package:ecommerce_app/providers/users_providers/product_providers.dart';
import 'package:ecommerce_app/services/products_services.dart';
import 'package:ecommerce_app/widgets/featured_products.dart';
import 'package:ecommerce_app/widgets/single_product_gridView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/widgets/recent_products.dart';
import 'package:ecommerce_app/widgets/horizontal_list.dart';
import 'package:ecommerce_app/pages/users_pages/cart_screen.dart';
import 'package:ecommerce_app/pages/users_pages/welcome_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          'E-Shoppins',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Style.Colors.mainColor,
        actions: [
          new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          new IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              )),
        ],
      ),
      drawer: new Drawer(
        child: _drawerChildren(),
      ),
      body: new ListView(
        children: [
          FeaturedProductsBuilder(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                new Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Categories",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          HorizontalList(),
          new Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up_outlined,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Popular products",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          RecentProductsBuilder(),
          SizedBox(height: 10)
        ],
      ),
    );
  }
  Widget _drawerChildren() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return new ListView(
      children: [
        new UserAccountsDrawerHeader(
          accountName:
              Text(userProvider.userModel?.name ?? "username lading...",),
          accountEmail: Text(userProvider.userModel?.email ?? "email loading...", ),
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
            onTap: () {},
            child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
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
