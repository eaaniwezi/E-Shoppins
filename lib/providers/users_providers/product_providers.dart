import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/services/products_services.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  UsersProductServices _usersProductServices = UsersProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _usersProductServices.getProducts();
    notifyListeners();
  }

  Future search({String? productName}) async {
    productsSearched =
        await _usersProductServices.searchProducts(productName: productName);
    notifyListeners();
  }
}
