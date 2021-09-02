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
    return Scaffold(
      appBar: buildAppBar(),
      body: appProvider.isLoading ? LoadingWidget() : cartBody(),
    );
  }

  Widget cartBody() {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: userProvider.userModel!.cart!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
                key: Key(userProvider.userModel!.cart![index].name.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
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
                              image:   userProvider.userModel!.cart![index].image![1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userProvider.userModel!.cart![index].name
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                maxLines: 2,
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(right: 2),
                              //   padding: EdgeInsets.all(8),
                              //   height: 25,
                              //   width: 25,
                              //   child: DecoratedBox(
                              //     decoration: BoxDecoration(
                              //       color: cart.cartproducts.colors[0],
                              //       shape: BoxShape.circle,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text:
                                  "\$${userProvider.userModel!.cart![index].price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Style.Colors.secondColor),
                              children: [
                                TextSpan(
                                    text:
                                        " x${userProvider.userModel!.cart![index].size}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                TextSpan(
                                  text: "   XL",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
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

  AppBar buildAppBar() {
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
            "3", // "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
