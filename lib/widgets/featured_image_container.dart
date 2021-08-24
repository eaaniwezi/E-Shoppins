import 'package:flutter/material.dart';

import 'package:ecommerce_app/model/product.dart';

class FeaturedImageContainer extends StatelessWidget {
  final ProductModel productPictures;
  const FeaturedImageContainer({
    Key? key,
    required this.productPictures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 220.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productPictures.pictures![0]),
              ),
            ),
          );
        
  }
}
