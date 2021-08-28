import 'package:ecommerce_app/providers/users_providers/product_providers.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:ecommerce_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/pages/users_pages/product_details_screen.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleProductGridView extends StatelessWidget {
  final ProductModel product;
  const SingleProductGridView({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
       return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(20.0),
            ),
          ),
          height: 400,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: LoadingWidget(),
                      ),
                    ),
                    Container(
                      // width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.zero,
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.circular(20.0),
                        ),
                        // image: DecorationImage(
                        //     image: NetworkImage(product.pictures![1]),
                        //     fit: BoxFit.cover),
                        ),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.pictures![1],
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            product.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 50,
                          child: Text(
                            '\$${product.price! / 100} \t',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(width: 5)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
