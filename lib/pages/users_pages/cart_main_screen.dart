import 'package:ecommerce_app/providers/users_providers/app_providers.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:ecommerce_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({Key? key}) : super(key: key);

  @override
  _CartMainScreenState createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: checkOutCard(),
      backgroundColor: userProvider.userModel!.cart!.isEmpty
          ? Style.Colors.whiteColor
          : Style.Colors.pinkColor,
      body: appProvider.isLoading ? LoadingWidget() : cartBody(),
    );
  }

  Widget checkOutCard() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.receipt_long_rounded,
                      color: Style.Colors.mainColor),
                ),
                Spacer(),
                Text(
                  "Add voucher code",
                  style: TextStyle(color: Style.Colors.mainColor),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Style.Colors.secondColor,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$337.15",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: 190,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Style.Colors.secondColor,
                        onPressed: () {},
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Style.Colors.mainColor,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cartBody() {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return userProvider.userModel!.cart!.isEmpty
        ? emptyCartContainer()
        : cartContainer();
  }

  Widget cartContainer() {
    final userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: userProvider.userModel!.cart!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
                key: UniqueKey(),
                // key: Key(userProvider.userModel!.cart![index].name.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    userProvider.removeFromCart(
                        cartItem: userProvider.userModel!.cart![index]);
                    userProvider.userModel!.cart!.removeAt(index);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [Spacer(), Icon(Icons.delete_forever)],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: userProvider.userModel!.cart![index].images
                                  .toString(),
                              // image:   userProvider.userModel!.cart![index].images![1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userProvider.userModel!.cart![index].name!
                                    .toUpperCase()
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text:
                                  "\$${userProvider.userModel!.cart![index].price! / 100} \n\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Style.Colors.secondColor),
                              children: [
                                TextSpan(
                                    text: "Size:  ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                TextSpan(
                                  text:
                                      "${userProvider.userModel!.cart![index].size}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Style.Colors.secondColor),
                                ),
                                TextSpan(
                                    text: "  Color:  ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                TextSpan(
                                  text:
                                      "${userProvider.userModel!.cart![index].color}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Style.Colors.secondColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget emptyCartContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('images/image/cart.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Text("You have no item in your cart!!"),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    final userProvider = Provider.of<UserProvider>(context);
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
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            userProvider.userModel!.cart!.length == 0
                ? ""
                : userProvider.userModel!.cart!.length == 1
                    ? "${userProvider.userModel!.cart!.length} item"
                    : "${userProvider.userModel!.cart!.length} items"
                        .toString(), // "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
