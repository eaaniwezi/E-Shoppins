import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() {
    // final userProvider = Provider.of<UserProvider>(context);
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Style.Colors.secondColor,
          )),
      title: Column(
        children: [
          Text(
            "Your Order(s)",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   userProvider.userModel!.cart!.length == 0
          //       ? ""
          //       : userProvider.userModel!.cart!.length == 1
          //           ? "${userProvider.userModel!.cart!.length} item"
          //           : "${userProvider.userModel!.cart!.length} items"
          //               .toString(), // "${demoCarts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}
