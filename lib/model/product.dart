import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
       var data = snapshot.data();
    return ProductModel(
      id: data['id'] ?? " ",
      name: snapshot['name'],
      description: snapshot['description'] ?? " ",
      category: snapshot['category'],
      brand: snapshot['brand'],
      quantity: snapshot['quantity'],
      price: snapshot['price'].t,
      sale: snapshot['sale'],
      featured: snapshot['featured'],
      colors: snapshot['colors'],
      sizes: snapshot['sizes'],
      pictures: snapshot['pictures'],
    );
  }
}
