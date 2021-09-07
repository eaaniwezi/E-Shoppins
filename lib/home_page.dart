import 'package:ecommerce_app/pages/users_pages/cart_main_screen.dart';
import 'package:ecommerce_app/pages/users_pages/order_screen.dart';
import 'package:ecommerce_app/providers/users_providers/product_providers.dart';
import 'package:ecommerce_app/services/products_services.dart';
import 'package:ecommerce_app/widgets/drawer_children.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartMainScreen()));
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
      ),
      drawer: new Drawer(
        child:DrawerChildren()
      ),
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


}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Style.Colors.mainColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(
              Icons.search,
              // color: black,
            ),
            title: TextField(
              textInputAction: TextInputAction.search,
              // onSubmitted: (pattern)async{
              //   await productProvider.search(productName: pattern);
              //   changeScreen(context, ProductSearchScreen());
              // },
              decoration: InputDecoration(
                hintText: "blazer, dress...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
