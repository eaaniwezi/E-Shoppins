import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/widgets/single_product_gridView.dart';
import 'package:ecommerce_app/providers/users_providers/product_providers.dart';

class RecentProductsBuilder extends StatelessWidget {
  const RecentProductsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<UsersProductProvider>(context, listen: false);
    return Container(
      margin: EdgeInsetsDirectional.all(5),
      height: 500,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: productProvider.products
            .map((item) => SingleProductGridView(
                  product: item,
                ))
            .toList(),
      ),
    );
  }
}
