import 'package:ecommerce_app/widgets/recent_products.dart';

class PopularProducts {
 final String? name;
 final String? picture;
 // ignore: non_constant_identifier_names
 final double? old_price;
  final double? price;

  PopularProducts({
    required this.name,
    required this.picture,
    // ignore: non_constant_identifier_names
    required this.old_price,
    required this.price,
  });
}

final List<PopularProducts> popularProducts = [
    PopularProducts(name: "Shirt", picture: "images/image/4.jpg", old_price: 200, price: 150),
    PopularProducts(name: "Shirt", picture: "images/image/1.jpg", old_price: 300, price: 100),
    PopularProducts(name: "Shirt", picture: "images/image/2.jpg", old_price: 350, price: 50),
    PopularProducts(name: "Shirt", picture: "images/image/3.jpg", old_price: 200, price: 120),
    PopularProducts(name: "Shirt", picture: "images/image/5.jpg", old_price: 200, price: 130),
    PopularProducts(name: "Shirt", picture: "images/image/4.jpg", old_price: 200, price: 12522),
    PopularProducts(name: "Shirt", picture: "images/image/2.jpg", old_price: 200, price: 150)
];
