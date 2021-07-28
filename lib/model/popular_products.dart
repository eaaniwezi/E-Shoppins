import 'package:flutter/material.dart';

import 'package:ecommerce_app/widgets/recent_products.dart';

class PopularProducts {
  final String? name;
  final String? description;
  final String? picture;
  final List<Color> colors;
  final List<String> otherPictures;
  // ignore: non_constant_identifier_names
  final double? old_price;
  final double? price;

  PopularProducts({
    // ignore: non_constant_identifier_names
    required this.name,
    required this.description,
    required this.picture,
    required this.colors,
    required this.otherPictures,
    required this.old_price,
    required this.price,
  });
}

final List<PopularProducts> popularProducts = [
  PopularProducts(
      name: "Watch",
      picture: "images/image/4.jpg",
      old_price: 200,
      price: 150,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/4.jpg",
        "images/image/1.jpg",
        "images/image/2.jpg",
        "images/image/3.jpg",
        "images/image/1.jpg",
      ]),
  PopularProducts(
      name: "Shorts",
      picture: "images/image/1.jpg",
      old_price: 300,
      price: 100,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/1.jpg",
        "images/image/2.jpg",
        "images/image/3.jpg",
        "images/image/4.jpg",
      ]),
  PopularProducts(
      name: "Shirt",
      picture: "images/image/2.jpg",
      old_price: 350,
      price: 50,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
       colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/1.jpg",
        "images/image/2.jpg",
        "images/image/3.jpg",
      ]),
  PopularProducts(
      name: "Shoes",
      picture: "images/image/3.jpg",
      old_price: 200,
      price: 120,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/3.jpg",
        "images/image/3.jpg",
        "images/image/3.jpg",
      ]),
  PopularProducts(
      name: "Slippers",
      picture: "images/image/5.jpg",
      old_price: 200,
      price: 130,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
     colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/5.jpg",
        "images/image/5.jpg",
        "images/image/5.jpg",
        "images/image/5.jpg",
      ]),
  PopularProducts(
      name: "Watch",
      picture: "images/image/4.jpg",
      old_price: 200,
      price: 125,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/4.jpg",
        "images/image/4.jpg",
        "images/image/4.jpg",
      ]),
  PopularProducts(
      name: "bag",
      picture: "images/image/6.png",
      old_price: 200,
      price: 150,
       description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
     colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/6.png",
        "images/image/6.png",
        "images/image/6.png",
        "images/image/6.png",
      ]),
  PopularProducts(
      name: "Shorts",
      picture: "images/image/1.jpg",
      old_price: 300,
      price: 100,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/1.jpg",
        "images/image/1.jpg",
        "images/image/1.jpg",
        "images/image/1.jpg",
      ]),
  PopularProducts(
      name: "Watch",
      picture: "images/image/4.jpg",
      old_price: 200,
      price: 150,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/1.jpg",
        "images/image/1.jpg",
        "images/image/1.jpg",
        "images/image/1.jpg",
      ]),
  PopularProducts(
      name: "Shirt",
      picture: "images/image/2.jpg",
      old_price: 350,
      price: 50,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/2.jpg",
        "images/image/2.jpg",
        "images/image/2.jpg",
        "images/image/2.jpg",
      ]),
  PopularProducts(
      name: "Shoes",
      picture: "images/image/3.jpg",
      old_price: 200,
      price: 120,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/3.jpg",
        "images/image/3.jpg",
        "images/image/3.jpg",
        "images/image/3.jpg",
      ]),
  PopularProducts(
      name: "Slippers",
      picture: "images/image/5.jpg",
      old_price: 200,
      price: 130,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/5.jpg",
        "images/image/5.jpg",
        "images/image/5.jpg",
        "images/image/5.jpg",
        "images/image/5.jpg",
      ]),
  PopularProducts(
      name: "Watch",
      picture: "images/image/4.jpg",
      old_price: 200,
      price: 125,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/4.jpg",
        "images/image/4.jpg",
        "images/image/4.jpg",
        "images/image/4.jpg",
      ]),
  PopularProducts(
      name: "bag",
      picture: "images/image/6.png",
      old_price: 200,
      price: 150,
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry\s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      colors: [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      otherPictures: [
        "images/image/4.jpg",
        "images/image/4.jpg",
        "images/image/4.jpg",
        "images/image/4.jpg",
      ])
];
