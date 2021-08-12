import '../../database/brand.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../database/category.dart';
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
  TextEditingController _searchCategoryController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  late Future<QuerySnapshot> searchResultsFuture;
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
  }

  clearSearch() {
    _searchCategoryController.clear();
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
          child: ListView(
            children: [
              _imageContainer(),
              _productNameContainer(),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontStyle: FontStyle.italic),
                    decoration: InputDecoration(border: OutlineInputBorder())),
                suggestionsCallback: (pattern) async {
                  return await _categoryService.getSuggestions(pattern);

                },
                itemBuilder: (context, suggestion,) {
                   List<DocumentSnapshot> category = <DocumentSnapshot>[];
                  return ListTile(
                    leading: Icon(Icons.help),
                    // ignore: unnecessary_brace_in_string_interps
                    title: Text(suggestion![category].toString()),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => ProductPage(product: suggestion)));
                  },

              ),
              // AutoSearchInput(data: _categoryService.getSuggestions(suggestion), maxElementsToDisplay: maxElementsToDisplay, onItemTap: onItemTap)
              // _searchCategoryContainer(),
              // _searchResult(),
            ],
          ),
        ),
      ),
    );
  }

  // _searchResult() {
  //   return FutureBuilder<List<CategoryService>>(
  //     future: CategoryService.ins
  //     builder: (context, sna) 
  //   );
  // }

  Widget _searchCategoryContainer() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                  color: Style.Colors.secondColor,
                  style: BorderStyle.solid,
                  width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                onFieldSubmitted: _categoryService
                    .handleSearchCategories(_searchCategoryController.text),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Style.Colors.mainColor,
                  fontSize: 15,
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Can't be empty";
                  } else
                    return null;
                },
                controller: _searchCategoryController,
                decoration: InputDecoration(
                  labelText: '  Search catergory',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Style.Colors.secondColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Style.Colors.secondColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: IconButton(
                onPressed: () {
                  print(_searchCategoryController.text);
                  clearSearch();
                },
                icon: Icon(Icons.close)))
      ],
    );
  }

  _productNameContainer() {
    return TextFormField(
      style: TextStyle(color: Style.Colors.mainColor),
      controller: _productNameController,
      decoration: InputDecoration(
          labelText: "Product name",
          labelStyle: TextStyle(color: Style.Colors.mainColor, fontSize: 12),
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
}
