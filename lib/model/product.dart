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
    _quantity = snapshot[QUANTITY];
    _category = snapshot[CATEGORY];
    _colors = snapshot[COLORS];
    _sizes = snapshot[SIZES];
    _pictures = snapshot[PICTURES];
    _name = snapshot[NAME];
  }
}
