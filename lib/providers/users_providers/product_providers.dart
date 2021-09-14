import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/services/products_services.dart';
import 'package:flutter/material.dart';

class UsersProductProvider with ChangeNotifier {
  UsersProductServices _usersProductServices = UsersProductServices();
  List<ProductModel> products = [];
  List<ProductModel> featuredProducts = [];
  List<ProductModel> productsSearched = [];

  UsersProductProvider.initialize() {
    loadProducts();
    loadFeaturedProducts();
    search( );
  }

  loadFeaturedProducts() async {
    featuredProducts = await _usersProductServices.getFeaturedProducts();
  }

  loadProducts() async {
    products = await _usersProductServices.getProducts();
    notifyListeners();
  }

  Future search({ String? productName}) async {
    productsSearched =
        await _usersProductServices.searchProducts(productName: productName);
    print(productsSearched);
    notifyListeners();
  }
}
