import '../../database/brand.dart';
import 'package:flutter/material.dart';
import '../../database/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

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

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: _appBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              _imageContainer(),
              TextFormField(
                style: TextStyle(color: Style.Colors.whiteColor),
                controller: _productNameController,
                decoration: InputDecoration(
                    labelText: "Product name",
                    labelStyle:
                        TextStyle(color: Style.Colors.whiteColor, fontSize: 12),
                    hintText:
                        "Product name should\'nt be more than 10 characters",
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
              )
            ],
          ),
        ),
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
                    color: Style.Colors.whiteColor,
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
                    color: Style.Colors.whiteColor,
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
                    color: Style.Colors.whiteColor,
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
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Style.Colors.whiteColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Style.Colors.mainColor,
      // elevation: 0,
      title: Text(
        "Add Product",
        style: TextStyle(
          color: Style.Colors.whiteColor,
        ),
      ),
    );
  }
}
