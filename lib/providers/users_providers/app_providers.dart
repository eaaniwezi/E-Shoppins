import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/services/products_services.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier{
  // bool isLoading = false;

  // void changeIsLoading(){
  //   isLoading = !isLoading;
  //   notifyListeners();
  // } 
   List<ProductModel> _featuredProducts = [];
   UsersProductServices _usersProductServices = UsersProductServices();
  AppProvider() {}
 

  List<ProductModel>  get featuredProducts => _featuredProducts;
}