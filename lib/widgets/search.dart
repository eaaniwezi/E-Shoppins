import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/pages/users_pages/search_product_screen.dart';

import 'package:ecommerce_app/providers/users_providers/product_providers.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<UsersProductProvider>(context);
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
              onSubmitted: (pattern) async {
                await productProvider.search(productName: pattern);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchProductScreen()));
              },
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
