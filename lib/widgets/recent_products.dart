import 'package:flutter/material.dart';

import 'package:ecommerce_app/model/popular_products.dart';
import 'package:ecommerce_app/widgets/single_product_gridView.dart';

class RecentProducts extends StatelessWidget {
  const RecentProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final List<PopularProducts> _popularProducts = popularProducts;
    return Container(
      margin: EdgeInsetsDirectional.all(5),
      height: 500,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _popularProducts.length,
        itemBuilder: (BuildContext context, int index) {
         return SingleProductGridView(
           name: _popularProducts[index].name, 
           picture: _popularProducts[index].picture,
           old_price: _popularProducts[index].old_price,
           price: _popularProducts[index].price,
           description: _popularProducts[index].description,
           colors: _popularProducts[index].colors,
           otherPictures: _popularProducts[index].otherPictures,
           );
        },
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
