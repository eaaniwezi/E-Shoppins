import '../database/add_brand.dart';
import 'package:flutter/material.dart';
import '../database/add_category.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  GlobalKey<FormState> _brandKey = GlobalKey();
  GlobalKey<FormState> _categoryKey = GlobalKey();
  AddBrandService _addBrandService = AddBrandService();
  AddCategoryService _addCategoryService = AddCategoryService();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: _drawerChildren(),
      ),
      backgroundColor: Style.Colors.mainColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 20.0),
              _firstPart(),
              const SizedBox(height: 10.0),
              _secondPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerChildren() {
    return new ListView(
      children: [
        new UserAccountsDrawerHeader(
          accountName: Text(
            "Lewiz-Shop",
            style: TextStyle(
              color: Style.Colors.whiteColor,
            ),
          ),
          accountEmail: Text(
            "eaaninwezi@gmail.com",
            style: TextStyle(
              color: Style.Colors.whiteColor,
            ),
          ),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              // backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Style.Colors.secondColor,
              ),
            ),
          ),
        ),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Dashboard"),
                leading:
                    Icon(Icons.dashboard, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Add Product"),
                leading: Icon(Icons.add, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Products List"),
                leading: Icon(FontAwesomeIcons.campground,
                    color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {
              // Navigator.pop(context);
              print("object");
              _addCategory();
            },
            child: ListTile(
                title: Text("Add Category"),
                leading: Icon(Icons.dashboard_customize_rounded,
                    color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {
              _addBrand();
            },
            child: ListTile(
                title: Text("Add brand"),
                leading: Icon(Icons.add_circle_rounded,
                    color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Brand list"),
                leading: Icon(Icons.category_rounded,
                    color: Style.Colors.secondColor))),
        Divider(),
        InkWell(
            onTap: () {
              // googleSignIn.signOut().then((value) => {
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => WelcomeScreen())),
              //     });
              // FirebaseAuth.instance.signOut().then((value) {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => WelcomeScreen()));
              // });
            },
            child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout, color: Style.Colors.secondColor))),
      ],
    );
  }

  _secondPart() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "7",
                        style: Theme.of(context).textTheme.display1!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.shoppingBag,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Orders',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 120,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "\$750",
                        style: Theme.of(context).textTheme.display1!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.cashRegister,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Revenue',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "0",
                        style: Theme.of(context).textTheme.display1!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        Icons.close,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Return',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 190,
                color: Style.Colors.mainColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "15 kms",
                        style: Theme.of(context)
                            .textTheme
                            // ignore: deprecated_member_use
                            .display1!
                            .copyWith(
                              fontSize: 24.0,
                              color: Style.Colors.mainColor,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.road,
                        color: Style.Colors.mainColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Distance',
                        style: TextStyle(
                          color: Style.Colors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _firstPart() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "7",
                        style: Theme.of(context).textTheme.display1!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.user,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Users',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 120,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "120",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.campground,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Products',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "15",
                        style: Theme.of(context).textTheme.display1!.copyWith(
                              color: Style.Colors.whiteColor,
                              fontSize: 24.0,
                            ),
                      ),
                      trailing: Icon(
                        Icons.category,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 190,
                color: Style.Colors.secondColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "25",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 24.0,
                              color: Style.Colors.whiteColor,
                            ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.smile,
                        color: Style.Colors.titleColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Sold',
                        style: TextStyle(
                          color: Style.Colors.whiteColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/image/splash.jpg"),
            )),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overall\nStats Sales",
                style: TextStyle(color: Style.Colors.whiteColor, fontSize: 12),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Welcome Lewiz!",
                style:
                    TextStyle(color: Style.Colors.whiteColor, fontSize: 14.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Style.Colors.whiteColor),
      backgroundColor: Style.Colors.mainColor,
      elevation: 0,
      title: Text(
        "Admin Dashboard",
        style: TextStyle(color: Style.Colors.secondColor, fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  void _addCategory() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryKey,
        child: TextFormField(
          controller: _categoryController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Field can't be empty";
            }
          },
          decoration: InputDecoration(hintText: "add category"),
        ),
      ),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(child: Text("Add"), onPressed: () {
          // ignore: unnecessary_null_comparison
          if (_categoryController.text != null) {
            _addCategoryService.createCategory(_categoryController.text);
          } Fluttertoast.showToast(msg: "Succesfully created ${_categoryController.text} category");
          Navigator.pop(context);
        }),
        // ignore: deprecated_member_use
        FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Style.Colors.redColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _addBrand() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandKey,
        child: TextFormField(
          controller: _brandController,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Field can't be empty";
            }
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(child: Text("Add"), onPressed: () {
            // ignore: unnecessary_null_comparison
          if (_brandController.text != null) {
            _addBrandService.createBrand(_brandController.text);
          } Fluttertoast.showToast(msg: "Succesfully created ${_brandController.text} brand");
          Navigator.pop(context);
        }),
        // ignore: deprecated_member_use
        FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Style.Colors.redColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
