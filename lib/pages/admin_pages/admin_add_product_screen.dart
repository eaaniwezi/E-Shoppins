import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import '../../database/add_product.dart';
import 'package:expandable/expandable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({Key? key}) : super(key: key);

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  ProductService _productService = ProductService();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productQuatityController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];

  List<String> selectedSizes = <String>[];

  int _selectedCategoryIndex = 0;
  _onSelectedCategory(int index) {
    setState(() => _selectedCategoryIndex = index);
  }

  int _selectedBrandIndex = 0;
  _onSelectedBrand(int index) {
    setState(() => _selectedBrandIndex = index);
  }

  var _image1;
  var _image2;
  var _image3;

  var imagePicker1;
  var imagePicker2;
  var imagePicker3;

  @override
  void initState() {
    super.initState();
    imagePicker1 = new ImagePicker();
    imagePicker2 = new ImagePicker();
    imagePicker3 = new ImagePicker();
  }

  // ImagePicker picker = ImagePicker();

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
                  SizedBox(height: 5),
                  _productQuantityContainer(),
                  SizedBox(height: 5),
                  _productPriceContainer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Available Sizes'),
                  ),
                  _productSizeContainer(),
                  SizedBox(height: 5),
                  _addProduct(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addProduct() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          uploadToDb();
        },
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Style.Colors.greenColor,
          ),
          child: Center(
            child: Text(
              "Add Product",
              style: TextStyle(
                color: Style.Colors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _productSizeContainer() {
    return Container(
      // color: Style.Colors.redColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('XS'),
                    onChanged: (value) => changeSelectedSize('XS')),
              ),
              Text('XS'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('S'),
                    onChanged: (value) => changeSelectedSize('S')),
              ),
              Text('S'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('M'),
                    onChanged: (value) => changeSelectedSize('M')),
              ),
              Text('M'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('L'),
                    onChanged: (value) => changeSelectedSize('L')),
              ),
              Text('L'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('XL'),
                    onChanged: (value) => changeSelectedSize('XL')),
              ),
              Text('XL'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('XXL'),
                    onChanged: (value) => changeSelectedSize('XXL')),
              ),
              Text('XXL'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('28'),
                    onChanged: (value) => changeSelectedSize('28')),
              ),
              Text('28'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('30'),
                    onChanged: (value) => changeSelectedSize('30')),
              ),
              Text('30'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('32'),
                    onChanged: (value) => changeSelectedSize('32')),
              ),
              Text('32'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('34'),
                    onChanged: (value) => changeSelectedSize('34')),
              ),
              Text('34'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('36'),
                    onChanged: (value) => changeSelectedSize('36')),
              ),
              Text('36'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('38'),
                    onChanged: (value) => changeSelectedSize('38')),
              ),
              Text('38'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('40'),
                    onChanged: (value) => changeSelectedSize('40')),
              ),
              Text('40'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('42'),
                    onChanged: (value) => changeSelectedSize('42')),
              ),
              Text('42'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('44'),
                    onChanged: (value) => changeSelectedSize('44')),
              ),
              Text('44'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('46'),
                    onChanged: (value) => changeSelectedSize('46')),
              ),
              Text('46'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('48'),
                    onChanged: (value) => changeSelectedSize('48')),
              ),
              Text('48'),
              Expanded(
                child: Checkbox(
                    activeColor: Style.Colors.greenColor,
                    value: selectedSizes.contains('50'),
                    onChanged: (value) => changeSelectedSize('50')),
              ),
              Text('50'),
            ],
          ),
        ],
      ),
    );
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  _productPriceContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Style.Colors.mainColor),
        keyboardType: TextInputType.number,
        controller: _productPriceController,
        decoration: InputDecoration(
          labelText: "Product Price",
          labelStyle: TextStyle(color: Style.Colors.mainColor, fontSize: 15),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'product price cant be empty';
          }
        },
      ),
    );
  }

  _productQuantityContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Style.Colors.mainColor),
        keyboardType: TextInputType.number,
        controller: _productQuatityController,
        decoration: InputDecoration(
          labelText: "Product Quantity",
          labelStyle: TextStyle(color: Style.Colors.mainColor, fontSize: 15),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'product Quantity cant be empty';
          }
        },
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
                  header: _expandedBrandsHeader(),
                  expanded: Container(),
                  collapsed: snapshot.data!.docs.length > 0
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
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
                                        if (_productNameController
                                            .text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Product name cant be empty");
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
                                      icon: _selectedBrandIndex != null &&
                                              _selectedBrandIndex == index
                                          ? Icon(Icons.done)
                                          : Icon(Icons.add),
                                      // ignore: unnecessary_null_comparison
                                      color: _selectedBrandIndex != null &&
                                              _selectedBrandIndex == index
                                          ? Style.Colors.greenColor
                                          : Style.Colors.titleColor,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              "No brand yet!! Need to create new brand",
                              style: TextStyle(
                                color: Style.Colors.redColor,
                              ),
                            ),
                          ),
                        ),
                );
        });
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
              // ignore: unnecessary_null_comparison
              child: _image1 == null
                  ? Center(
                      child: IconButton(
                        onPressed: () async {
                          XFile image = await imagePicker1.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image1 = File(image.path);
                            print("lewiiz");
                            print(image.path.toString());
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Style.Colors.mainColor,
                        ),
                      ),
                    )
                  : Image.file(
                      _image1,
                      fit: BoxFit.fill,
                      width: double.infinity,
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
              child: _image2 == null
                  ? Center(
                      child: IconButton(
                        // ignore: invalid_use_of_visible_for_testing_member
                        onPressed: () async {
                          XFile image = await imagePicker2.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image2 = File(image.path);
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Style.Colors.mainColor,
                        ),
                      ),
                    )
                  : Image.file(
                      _image2,
                      fit: BoxFit.fill,
                      width: double.infinity,
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
                child: _image3 == null
                    ? Center(
                        child: IconButton(
                          onPressed: () async {
                            XFile image = await imagePicker3.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _image3 = File(image.path);
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: Style.Colors.mainColor,
                          ),
                        ),
                      )
                    : Image.file(
                        _image3,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
              )),
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

  _getCategories() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("categories").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ExpandablePanel(
                  header: _expandedHeader(),
                  expanded: Container(),
                  collapsed: snapshot.data!.docs.length > 0
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Row(
                                    children: [
                                      Text(
                                        data['category'],
                                        style: TextStyle(
                                          color:
                                              // ignore: unnecessary_null_comparison
                                              _selectedCategoryIndex != null &&
                                                      _selectedCategoryIndex ==
                                                          index
                                                  ? Style.Colors.greenColor
                                                  : Style.Colors.secondColor,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          if (_productNameController
                                              .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Product name cant be empty");
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
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              "No category yet!! Need to create new category",
                              style: TextStyle(
                                color: Style.Colors.redColor,
                              ),
                            ),
                          ),
                        ),
                );
        });
  }

  _expandedBrandsHeader() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "Choose a brand",
        style: TextStyle(color: Style.Colors.mainColor, fontSize: 15),
      ),
    );
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

  void uploadToDb() async {
    if (_formKey.currentState!.validate()) {
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final String picture2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final String picture3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          //  StorageUploadTask uploadTask1 = firebaseStorage.ref().child(picture1).putFile(_image1);
          Reference ref1 = firebaseStorage.ref().child(picture1);
          UploadTask uploadTask1 = ref1.putFile(_image1);

          Reference ref2 = firebaseStorage.ref().child(picture2);
          UploadTask uploadTask2 = ref2.putFile(_image2);

          Reference ref3 = firebaseStorage.ref().child(picture3);
          UploadTask uploadTask3 = ref3.putFile(_image3);
          
          // TaskSnapshot snapshot1 = await uploadTask1.whenComplete(() => snaps)

          uploadTask1.whenComplete(() {
            imageUrl1 = ref1.getDownloadURL().toString();
          }).catchError((e) {
            print(e);
            Fluttertoast.showToast(msg: e.toString());
          });
   

          uploadTask2.whenComplete(() {
            imageUrl2 = ref2.getDownloadURL() as String;
          }).catchError((e) {
            print(e);
            Fluttertoast.showToast(msg: e.toString());
          });

          uploadTask3.whenComplete(() {
            imageUrl3 = ref1.getDownloadURL() as String;
          }).catchError((e) {
            print(e);
            Fluttertoast.showToast(msg: e.toString());
          });

          
          List<String> imageList = [_image1.toString(), _image2.toString(), _image3.toString()];

          _productService.uploadProduct(
            productName: _productNameController.text,
            prices: double.parse(_productPriceController.text),
            quantity: int.parse(_productQuatityController.text),
           images: imageList,
          );
           Fluttertoast.showToast(
              msg: "Successful added to database");
        } else {
          Fluttertoast.showToast(
              msg: "At least one size should be f*cking selected");
        }
      } else {
        Fluttertoast.showToast(
            msg: "All three images must be f*cking provided!!");
      }
    } 
  }
}
