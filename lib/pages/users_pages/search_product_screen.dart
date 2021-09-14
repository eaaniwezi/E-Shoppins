import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/widgets/search_result.dart';
import 'package:ecommerce_app/pages/users_pages/cart_main_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:ecommerce_app/pages/users_pages/product_details_screen.dart';
import 'package:ecommerce_app/providers/users_providers/product_providers.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<UsersProductProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      body: productProvider.productsSearched.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No products Found"),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  product: productProvider
                                      .productsSearched[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SearchResult(
                          product: productProvider.productsSearched[index]),
                    ));
              }),
    );
  }

  _appBar() {
    final productProvider = Provider.of<UsersProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      title: Text(
     productProvider.productsSearched.length > 1 ?    'Search-Results' : 'Search-Result',
        style: TextStyle(color: Colors.white, fontSize: 15),
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
