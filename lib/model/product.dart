import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   static const ID = "id";
//   static const NAME = "name";
//   static const PICTURE = "pictures";
//   static const PRICE = "price";
//   static const DESCRIPTION = "description";
//   static const CATEGORY = "category";
//   static const FEATURED = "featured";
//   static const QUANTITY = "quantity";
//   static const BRAND = "brand";
//   static const SALE = "sale";
//   static const SIZES = "sizes";
//   static const COLORS = "colors";

// String? _id;
// String? _name;
// String? _description;
// String? _category;
// String? _brand;
// int? _quantity;
// int? _price;
// bool? _sale;
// bool? _featured;
// List? _colors;
// List? _sizes;
// List? _pictures;

//   String? get id => _id;
//   String? get name => _name;
//   String? get brand => _brand;
//   String? get category => _category;
//   String? get description => _description;
//   int? get quantity => _quantity;
//   int? get price => _price;
//   bool? get featured => _featured;
//   bool? get sale => _sale;
//   List? get colors => _colors;
//   List? get sizes => _sizes;
//   List? get picture => _pictures;

//    ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
//     _id = snapshot.data()?.[ID] ?? '';
//     _brand = snapshot.data[BRAND];
//     _sale = snapshot.data[SALE];
//     _description = snapshot.data[DESCRIPTION] ?? " ";
//     _featured = snapshot.data[FEATURED];
//     _price = snapshot.data[PRICE].floor();
//     _category = snapshot.data[CATEGORY];
//     _colors = snapshot.data[COLORS];
//     _sizes = snapshot.data[SIZES];
//     _name = snapshot.data[NAME];
//     _pictures = snapshot.data[PICTURE];

//   }
// }

class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final String? brand;
  final int? quantity;
  final int? price;
  final bool? sale;
  final bool? featured;
  final List? colors;
  final List? sizes;
  final List<String>? pictures;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.brand,
    this.quantity,
    this.price,
    this.sale,
    this.featured,
    this.colors,
    this.sizes,
    this.pictures,
  });

  factory ProductModel.fromDocument(DocumentSnapshot snapshot) {
    return ProductModel(
      id: snapshot['id'] ?? " ",
      name: snapshot['name'],
      description: snapshot['description'] ?? " ",
      category: snapshot['category'],
      brand: snapshot['brand'],
      quantity: snapshot['quantity'],
      price: snapshot['price'],
      sale: snapshot['sale'],
      featured: snapshot['featured'],
      colors: snapshot['colors'],
      sizes: snapshot['sizes'],
      pictures: snapshot['pictures'],
    );
  }
}
