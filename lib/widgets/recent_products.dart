import 'package:ecommerce_app/providers/users_providers/product_providers.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/model/popular_products.dart';
import 'package:ecommerce_app/widgets/single_product_gridView.dart';
import 'package:provider/provider.dart';

class RecentProducts extends StatelessWidget {
  const RecentProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPovider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    // final List<PopularProducts> _popularProducts = popularProducts;
    return Container(
      margin: EdgeInsetsDirectional.all(5),
      height: 500,
      child: GridView.count(
        // scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        // primary: false,
        // crossAxisSpacing: 10,
        // mainAxisSpacing: 20,
        crossAxisCount: 2,
        children: productProvider.products
            .map((item) => GestureDetector(
                  onTap: () {},
                  child: SingleProductGridView(
                    product: item,
                  ),
                ))
            .toList(),
      ),
      // child: GridView.builder(
      //   scrollDirection: Axis.vertical,
      //   itemCount: _popularProducts.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Padding(
      //       padding: const EdgeInsets.only(
      //           left: 2, right: 2, top: 0.5, bottom: 0.05),
      //       child: SingleProductGridView(
      //         name: productProvider[index].name,
      //         picture: _popularProducts[index].picture,
      //         old_price: _popularProducts[index].old_price,
      //         price: _popularProducts[index].price,
      //         description: _popularProducts[index].description,
      //         colors: _popularProducts[index].colors,
      //         otherPictures: _popularProducts[index].otherPictures,
      //       ),
      //     );
      //   },
      //   gridDelegate:
      //       new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      // ),
    );
  }
}
