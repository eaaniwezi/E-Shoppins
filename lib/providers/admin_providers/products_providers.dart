import 'package:flutter/material.dart';

class AdminProductProvider with ChangeNotifier{
  List<String> selectedColors = [];

  addColors(String color){
    selectedColors.add(color);
    print(selectedColors.length.toString());
    notifyListeners();
  }

  removeColor(String color){
    selectedColors.remove(color);
    print(selectedColors.length.toString());
    notifyListeners();
  }

}