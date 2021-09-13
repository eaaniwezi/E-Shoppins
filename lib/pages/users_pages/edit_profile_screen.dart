import 'package:ecommerce_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/pages/users_pages/cart_main_screen.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserServices _userServices = UserServices();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            _profilePageHeader(),
            SizedBox(height: 15),
            _pictureContainer(),
            SizedBox(height: 35),
            buildTextField(
                "Full Name", userProvider.userModel!.name.toString()),
            buildTextField(
              "Phone-number",
              userProvider.userModel!.phoneNumber!.isEmpty
                  ? "phone number is empty"
                  : userProvider.userModel!.phoneNumber.toString(),
            ),
            buildTextField(
              "Location",
              userProvider.userModel!.address!.isEmpty
                  ? "location is empty"
                  : userProvider.userModel!.address.toString(),
            ),
            SizedBox(
              height: 35,
            ),
            _buttons(),
          ],
        ),
      ),
    );
  }

  _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ignore: deprecated_member_use
        OutlineButton(
          padding: EdgeInsets.symmetric(horizontal: 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () {
            print("started updating profile");
            _userServices.updateUsers({
              "name": "updatedname",
              "phoneNumber": "UpdatedPhoneNumber",
              "address": "nothing"
            });
            print("done updating profile");
          },
          color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 50),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _pictureContainer() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    ))),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  _profilePageHeader() {
    final userProvider = Provider.of<UserProvider>(context);
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Style.Colors.mainColor,
              ),
            )),
        Text(
          "Edit profile",
          style: TextStyle(
            color: Style.Colors.mainColor,
            fontSize: 18,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CartMainScreen()));
          },
          child: Stack(
            children: <Widget>[
              new Icon(
                Icons.shopping_cart_outlined,
              ),
              new Positioned(
                right: 0,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: new Text(
                    '${userProvider.userModel!.cart!.length}',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextField(
    String labelText,
    String placeholder,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
