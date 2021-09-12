import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profilePageHeader(),
                SizedBox(height: 10),
                _profilePictureContainer(),
                SizedBox(height: 30),
                _textContainer(text: "Account"),
                SizedBox(height: 20),
                _profileAccountCard(),
                SizedBox(height: 30),
                _textContainer(text: "Others"),
                SizedBox(height: 20),
                _profileOthersContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textContainer({required String text}) {
    return Text(
      text,
      style: TextStyle(
        color: Style.Colors.mainColor,
        fontSize: 18,
      ),
    );
  }

  _profileOthersContainer() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "About",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.contact_phone,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Style.Colors.redColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Log-out",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
          ],
        ),
      ),
    );
  }

  _profileAccountCard() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Location",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Shipping",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.payment,
                    color: Style.Colors.secondColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Payment",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
              color: Style.Colors.secondColor,
            ),
          ],
        ),
      ),
    );
  }

  _profilePictureContainer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 4),
                color: Colors.black,
              ),
            ],
            image: DecorationImage(
              image: AssetImage("images/image/splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aninwezi Emmanuel",
              style: TextStyle(
                color: Style.Colors.mainColor,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "+79509697254",
              style: TextStyle(
                color: Style.Colors.mainColor,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Style.Colors.secondColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Style.Colors.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
          "Profile",
          style: TextStyle(
            color: Style.Colors.mainColor,
            fontSize: 18,
          ),
        ),
        Spacer(),
        Stack(
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
      ],
    );
  }
}
