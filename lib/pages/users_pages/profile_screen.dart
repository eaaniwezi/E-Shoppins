import 'package:ecommerce_app/pages/users_pages/cart_main_screen.dart';
import 'package:ecommerce_app/pages/users_pages/edit_profile_screen.dart';
import 'package:ecommerce_app/pages/users_pages/order_screen.dart';
import 'package:ecommerce_app/pages/users_pages/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
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
                      color: Colors.grey[700],
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
                      color: Colors.grey[700],
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
              child: InkWell(
                onTap: () {
                  googleSignIn.signOut().then((value) => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen())),
                      });
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  });
                },
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
    final userProvider = Provider.of<UserProvider>(context);
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
                    userProvider.userModel!.address!.isEmpty
                        ? "Location"
                        : userProvider.userModel?.address ??
                            "Location loading...",
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
              child: InkWell(
                onTap: () async {
                  await userProvider.getOrders();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderScreen()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Style.Colors.secondColor,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Order history",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
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
                      color: Colors.grey[700],
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
    final userProvider = Provider.of<UserProvider>(context);
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
              userProvider.userModel?.name ?? "username loading...",
              style: TextStyle(
                color: Style.Colors.mainColor,
                fontSize: 15,
              ),
            ),
            // SizedBox(height: 5),
            Text(
              userProvider.userModel?.email ?? "email loading...",
              style: TextStyle(
                color: Style.Colors.mainColor,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 5),
            Text(
              userProvider.userModel?.phoneNumber ?? "phone number loading...",
              style: TextStyle(
                color: Style.Colors.mainColor,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async{
                   await userProvider.getOrders();
                   await userProvider.reloadUserModel();
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Style.Colors.greenColor,
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
}
