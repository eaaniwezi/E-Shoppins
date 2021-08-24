// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   final String? id;
//   final String? name;
//   final String? description;
//   final String? category;
//   final String? brand;
//   final int? quantity;
//   final int? price;
//   final bool? sale;
//   final bool? featured;
//   final List? colors;
//   final List? sizes;
//   final List<String>? pictures;

//   ProductModel({
//     this.id,
//     this.name,
//     this.description,
//     this.category,
//     this.brand,
//     this.quantity,
//     this.price,
//     this.sale,
//     this.featured,
//     this.colors,
//     this.sizes,
//     this.pictures,
//   });

//   factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
//       //  var data = snapshot.data();
//     return ProductModel(
//       id: snapshot['id'] ?? " ",
//       name: snapshot['name'],
//       description: snapshot['description'] ?? " ",
//       category: snapshot['category'],
//       brand: snapshot['brand'],
//       quantity: snapshot['quantity'],
//       price: snapshot['price'].t,
//       sale: snapshot['sale'],
//       featured: snapshot['featured'],
//       colors: snapshot['colors'],
//       sizes: snapshot['sizes'],
//       pictures: snapshot['pictures'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURES = "pictures";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const QUANTITY = "quantity";
  static const BRAND = "brand";
  static const SALE = "sale";
  static const SIZES = "sizes";
  static const COLORS = "colors";

  String? _id;
  String? _name;
  List<dynamic>? _pictures;
  String? _description;
  String? _category;
  String? _brand;
  int? _quantity;
  int? _price;
  bool? _sale;
  bool? _featured;
  List? _colors;
  List? _sizes;

  String? get id => _id;

  String? get name => _name;

  List<dynamic>? get pictures => _pictures;

  String? get brand => _brand;

  String? get category => _category;

  String? get description => _description;

  int? get quantity => _quantity;

  int? get price => _price;

  bool? get featured => _featured;

  bool? get sale => _sale;

  List? get colors => _colors;

  List? get sizes => _sizes;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _brand = snapshot[BRAND];
    _sale = snapshot[SALE];
    _description = snapshot[DESCRIPTION] ?? " ";
    _featured = snapshot[FEATURED];
    _price = snapshot[PRICE].floor();
    _category = snapshot[CATEGORY];
    _colors = snapshot[COLORS];
    _sizes = snapshot[SIZES];
    _pictures = snapshot[PICTURES];
    _name = snapshot[NAME];
  }
}
