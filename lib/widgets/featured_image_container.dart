import 'package:ecommerce_app/pages/users_pages/product_details_screen.dart';
import 'package:ecommerce_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:transparent_image/transparent_image.dart';

class FeaturedImageContainer extends StatelessWidget {
  final ProductModel productPictures;
  const FeaturedImageContainer({
    Key? key,
    required this.productPictures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: productPictures)));
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: LoadingWidget(),
            ),
          ),
          Container(
            height: 220.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
             
            ),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: productPictures.pictures![0],
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 30.0,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: 250.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productPictures.name.toString().toUpperCase(),
                    style: TextStyle(
                        height: 1.5,
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: 250.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\$${productPictures.price! / 100} \t',
                    style: TextStyle(
                        height: 1.5,
                        color: Style.Colors.secondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
