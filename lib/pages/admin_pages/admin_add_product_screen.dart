import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/add_product.dart';
import 'package:expandable/expandable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import '../../providers/admin_providers/products_providers.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({Key? key}) : super(key: key);

  @override
  _AdminAddProductScreenState createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  AdminProductServices _productService = AdminProductServices();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productQuatityController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<String> selectedSizes = <String>[];
  String? _currentCategory;
  String? _currentBrand;

  int _selectedCategoryIndex = 0;
  _onSelectedCategory(int index) {
    setState(() => _selectedCategoryIndex = index);
  }

  int _selectedBrandIndex = 0;
  _onSelectedBrand(int index) {
    setState(() => _selectedBrandIndex = index);
  }

  bool isLoading = false;
  var _image1;
  var _image2;
  var _image3;
  var imagePicker1;
  var imagePicker2;
  var imagePicker3;

  bool onSale = false;
  bool featured = false;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> colors = <String>[];

  @override
  void initState() {
    super.initState();
    imagePicker1 = new ImagePicker();
    imagePicker2 = new ImagePicker();
    imagePicker3 = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.Colors.whiteColor,
      appBar: _appBar(),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Style.Colors.greenColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sending data to the database!!",
                      style: TextStyle(
                          color: Style.Colors.greenColor, fontSize: 15),
                    ),
                  ),
                  Text(
                    "Wait for a few seconds....",
                    style:
                        TextStyle(color: Style.Colors.greenColor, fontSize: 15),
                  ),
                ],
              ),
            )
          : Form(
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
                          child: Text('Available Colors'),
                        ),
                        _colorContainer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Available Sizes'),
                        ),
                        _productSizeContainer(),
                        SizedBox(height: 5),
                        _optional(),
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

  _optional() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Sale'),
            SizedBox(
              width: 10,
            ),
            Switch(
                activeColor: Style.Colors.greenColor,
                value: onSale,
                onChanged: (value) {
                  setState(() {
                    onSale = value;
                  });
                }),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Featured'),
            SizedBox(
              width: 10,
            ),
            Switch(
                activeColor: Style.Colors.greenColor,
                value: featured,
                onChanged: (value) {
                  setState(() {
                    featured = value;
                  });
                }),
          ],
        ),
      ],
    );
  }

  _colorContainer() {
    final productProvider = Provider.of<ProductProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('red')) {
                    productProvider.removeColor('red');
                  } else {
                    productProvider.addColors('red');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('red')
                          ? Colors.blue
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('yellow')) {
                    productProvider.removeColor('yellow');
                  } else {
                    productProvider.addColors('yellow');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('yellow')
                          ? red
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('blue')) {
                    productProvider.removeColor('blue');
                  } else {
                    productProvider.addColors('blue');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('blue')
                          ? red
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('green')) {
                    productProvider.removeColor('green');
                  } else {
                    productProvider.addColors('green');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('green')
                          ? red
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('white')) {
                    productProvider.removeColor('white');
                  } else {
                    productProvider.addColors('white');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('white')
                          ? red
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (productProvider.selectedColors.contains('black')) {
                    productProvider.removeColor('black');
                  } else {
                    productProvider.addColors('black');
                  }
                  setState(() {
                    colors = productProvider.selectedColors;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: productProvider.selectedColors.contains('black')
                          ? red
                          : grey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundColor: black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _addProduct() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: isLoading
          ? CircularProgressIndicator()
          : GestureDetector(
              onTap: () {
                try {
                  uploadToDb();
                  print(_currentCategory);
                  print(_currentBrand);
                } catch (e) {
                  print(e.toString());
                  Fluttertoast.showToast(msg: e.toString());
                }
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                            setState(() {
                                              _currentBrand = data['brand'];
                                            });
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          data['category'],
                                          style: TextStyle(
                                            color:
                                                // ignore: unnecessary_null_comparison
                                                _selectedCategoryIndex !=
                                                            null &&
                                                        _selectedCategoryIndex ==
                                                            index
                                                    ? Style.Colors.greenColor
                                                    : Style.Colors.secondColor,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            if (_productNameController
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Product name cant be empty");
                                            } else if (_productNameController
                                                .text.isNotEmpty) {
                                              print(data['category']);
                                              setState(() {
                                                _currentCategory =
                                                    data['category'];
                                              });
                                              print("object");
                                              print(
                                                  _currentCategory.toString());
                                              _onSelectedCategory(index);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "     Successfully choosen\n${_productNameController.text} for ${data['category']} category");
                                            }
                                          },
                                          icon:
                                              // ignore: unnecessary_null_comparison
                                              _selectedCategoryIndex != null &&
                                                      _selectedCategoryIndex ==
                                                          index
                                                  ? Icon(Icons.done)
                                                  : Icon(Icons.add),
                                          color:
                                              // ignore: unnecessary_null_comparison
                                              _selectedCategoryIndex != null &&
                                                      _selectedCategoryIndex ==
                                                          index
                                                  ? Style.Colors.greenColor
                                                  : Style.Colors.titleColor,
                                        ),
                                      ],
                                    ),
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
      setState(() {
        isLoading = true;
      });
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (_currentBrand != null) {
          if (_currentCategory != null) {
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

              TaskSnapshot snapshot1 =
                  await firebaseStorage.ref().child(picture1).putFile(_image1);
              TaskSnapshot snapshot2 =
                  await firebaseStorage.ref().child(picture2).putFile(_image2);
              TaskSnapshot snapshot3 =
                  await firebaseStorage.ref().child(picture3).putFile(_image3);

              if ((snapshot1.state == TaskState.success) &&
                  (snapshot2.state == TaskState.success) &&
                  ((snapshot3.state == TaskState.success))) {
                imageUrl1 = await snapshot1.ref.getDownloadURL();
                imageUrl2 = await snapshot2.ref.getDownloadURL();
                imageUrl3 = await snapshot3.ref.getDownloadURL();

                List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];
                print(imageList);

                _productService.uploadProduct({
                  "name": _productNameController.text,
                  "price": double.parse(_productPriceController.text),
                  "sizes": selectedSizes,
                  "colors": colors,
                  "pictures": imageList,
                  "quantity": int.parse(_productQuatityController.text),
                  "brand": _currentBrand,
                  "category": _currentCategory,
                  'sale': onSale,
                  'featured': featured
                });

                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: "Successfully added products to database");
                Navigator.pop(context);
              } else {
                setState(() {
                  isLoading = false;
                });
                print(
                    "Error from image ${snapshot1.state.toString() + snapshot2.state.toString() + snapshot3.state.toString()}");
                Fluttertoast.showToast(
                    msg:
                        "Error from image ${snapshot1.state.toString() + snapshot2.state.toString() + snapshot3.state.toString()}");
              }
            } else {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(
                  msg: "At least one size should be f*cking selected");
            }
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Please select on catergory");
          }
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Please select one brand");
        }
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "All three images must be f*cking provided!!");
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
