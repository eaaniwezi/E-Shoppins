import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            image_location: "images/cats/accessories.png", image_caption: "Accessories",
          ),
          Category(
            image_location: "images/cats/dress.png", image_caption: "Dress",
          ),
          Category(
            image_location: "images/cats/formal.png", image_caption: "Formal",
          ),
          Category(
            image_location: "images/cats/informal.png", image_caption: "Informal",
          ),
          Category(
            image_location: "images/cats/jeans.png", image_caption: "Jeans",
          ),
          Category(
            image_location: "images/cats/shoe.png", image_caption: "Shoe",
          ),
          Category(
            image_location: "images/cats/tshirt.png", image_caption: "Tshirt",
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String image_location;
  // ignore: non_constant_identifier_names
  final String image_caption;
  const Category({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.image_location,
    // ignore: non_constant_identifier_names
    required this.image_caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () => print("object"),
        child: Column(
          children: [
           Container(
             height: 80,
             width: 90,
             child:  Image.asset(image_location, color: Style.Colors.secondColor,),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(image_caption, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
     
    );
  }
}
