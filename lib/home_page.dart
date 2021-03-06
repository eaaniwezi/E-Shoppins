import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/widgets/search.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/widgets/recent_products.dart';
import 'package:ecommerce_app/widgets/drawer_children.dart';
import 'package:ecommerce_app/widgets/horizontal_list.dart';
import 'package:ecommerce_app/widgets/featured_products.dart';
import 'package:ecommerce_app/pages/users_pages/cart_main_screen.dart';
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
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: _appBar(),
      drawer: new Drawer(child: DrawerChildren()),
      body: new ListView(
        children: [
          SearchBar(),
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

  _appBar() {
    final userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      title: Text(
        'E-Shoppins',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      backgroundColor: Style.Colors.mainColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartMainScreen()));
              },
              child: Stack(
                children: <Widget>[
                  new Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        '${userProvider.userModel!.cart!.length}',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
