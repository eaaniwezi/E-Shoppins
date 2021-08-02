import 'package:ecommerce_app/pages/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class SingleProductGridView extends StatelessWidget {
  final name;
  final picture;
  // ignore: non_constant_identifier_names
  final old_price;
  final price;
  final description;
  final colors;
  final otherPictures;
  const SingleProductGridView({
    this.name,
    this.picture,
    // ignore: non_constant_identifier_names
    this.old_price,
    this.price,
    this.description,
    this.colors, this.otherPictures,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new ProductDetailsScreen(
                product_details_current_price: price,
                product_details_name: name,
                product_details_old_price: old_price,
                product_details_picture: picture,
                product_details_description: description,
                product_details_color: colors,
                other_pictures: otherPictures,
              ))),
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
                    image: DecorationImage(
                        image: AssetImage(picture), fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(2.4),
                child: Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "\$$old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    SizedBox(width: 5)
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
