import 'package:fluttertoast/fluttertoast.dart';
import 'package:expandable/expandable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import '../../database/brand.dart';

import '../../database/category.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({Key? key}) : super(key: key);

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];

  int _selectedCategoryIndex = 0;

  _onSelectedCategory(int index) {
    setState(() => _selectedCategoryIndex = index);
  }


  int _selectedBrandIndex = 0;

  _onSelectedBrand(int index) {
    setState(() => _selectedBrandIndex = index);
  }

  String ref = 'categories';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.whiteColor,
      appBar: _appBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _imageContainer(),
                  _productNameContainer(),
                  SizedBox(height: 5),
                  _getCategories(),
                  SizedBox(height: 5),
                   _getBrands(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _productNameContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Style.Colors.mainColor),
        controller: _productNameController,
        decoration: InputDecoration(
            labelText: "Product name",
            labelStyle: TextStyle(color: Style.Colors.mainColor, fontSize: 15),
            hintText: "Product name should\'nt be more than 10 characters",
            hintStyle: TextStyle(
              color: Style.Colors.secondColor,
              fontSize: 12,
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return 'product name cant be empty';
          } else if (value.length > 10) {
            return 'product name cant be more than 10 characters';
          }
        },
      ),
    );
  }

  _imageContainer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Style.Colors.secondColor,
                    style: BorderStyle.solid,
                    width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Style.Colors.mainColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Style.Colors.secondColor,
                    style: BorderStyle.solid,
                    width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Style.Colors.mainColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Style.Colors.secondColor,
                    style: BorderStyle.solid,
                    width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Style.Colors.mainColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Style.Colors.mainColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Style.Colors.whiteColor,
      // elevation: 0,
      title: Text(
        "Add Product",
        style: TextStyle(
          color: Style.Colors.mainColor,
        ),
      ),
    );
  }

  _getBrands() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("brands").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ExpandablePanel(
                  header: _expandedHeader(),
                  expanded: Container(),
                  collapsed: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Card(
                          child: Row(
                            children: [
                              Text(
                                data['brand'],
                                style: TextStyle(
                                  // ignore: unnecessary_null_comparison
                                  color: _selectedBrandIndex != null &&
                                          _selectedBrandIndex == index
                                      ? Style.Colors.greenColor
                                      : Style.Colors.secondColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  if (_productNameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Product name cant be empty");
                                  } else if (_productNameController
                                      .text.isNotEmpty) {
                                    print(data['brand']);
                                    _onSelectedBrand(index);
                                    Fluttertoast.showToast(
                                        msg:
                                            "     Successfully choosen\n${_productNameController.text} for ${data['brand']} brand");
                                  }
                                },
                                // ignore: unnecessary_null_comparison
                                icon: _selectedBrandIndex != 0 &&
                                        _selectedBrandIndex == index
                                    ? Icon(Icons.done)
                                    : Icon(Icons.add),
                                // ignore: unnecessary_null_comparison
                                color: _selectedBrandIndex != 0 &&
                                        _selectedBrandIndex == index
                                    ? Style.Colors.greenColor
                                    : Style.Colors.titleColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
        });
  }

  _getCategories() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("categories").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ExpandablePanel(
                  header: _expandedHeader(),
                  expanded: Container(),
                  collapsed: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Card(
                          child: Row(
                            children: [
                              Text(
                                data['category'],
                                style: TextStyle(
                                  // ignore: unnecessary_null_comparison
                                  color: _selectedCategoryIndex != null &&
                                          _selectedCategoryIndex == index
                                      ? Style.Colors.greenColor
                                      : Style.Colors.secondColor,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  if (_productNameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Product name cant be empty");
                                  } else if (_productNameController
                                      .text.isNotEmpty) {
                                    print(data['category']);
                                    _onSelectedCategory(index);
                                    Fluttertoast.showToast(
                                        msg:
                                            "     Successfully choosen\n${_productNameController.text} for ${data['category']} category");
                                  }
                                },
                                // ignore: unnecessary_null_comparison
                                icon: _selectedCategoryIndex != null &&
                                        _selectedCategoryIndex == index
                                    ? Icon(Icons.done)
                                    : Icon(Icons.add),
                                // ignore: unnecessary_null_comparison
                                color: _selectedCategoryIndex != null &&
                                        _selectedCategoryIndex == index
                                    ? Style.Colors.greenColor
                                    : Style.Colors.titleColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
        });
  }

  _expandedHeader() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "Choose a category",
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 15),
      ),
    );
  }
}
