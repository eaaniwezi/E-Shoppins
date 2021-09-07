import 'package:ecommerce_app/model/cart_item.dart';
import 'package:ecommerce_app/providers/users_providers/app_providers.dart';
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';
import 'package:ecommerce_app/services/order_services.dart';
import 'package:ecommerce_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uuid/uuid.dart';

class CartMainScreen extends StatefulWidget {
  const CartMainScreen({Key? key}) : super(key: key);

  @override
  _CartMainScreenState createState() => _CartMainScreenState();
}

class _CartMainScreenState extends State<CartMainScreen> {
  OrderServices _orderServices = OrderServices();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _orderSummaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar:
          userProvider.userModel!.cart!.isEmpty ? Text("") : checkOutCard(),
      backgroundColor: userProvider.userModel!.cart!.isEmpty
          ? Style.Colors.whiteColor
          : Style.Colors.pinkColor,
      body: appProvider.isLoading ? LoadingWidget() : cartBody(),
    );
  }

  Widget checkOutCard() {
    final userProvider = Provider.of<UserProvider>(context);
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
            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "No code available at the moment");
              },
              child: Row(
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
                        // text: "\$337.15",
                        text:
                            " \$${userProvider.userModel!.totalCartPrice! / 100}",
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
                        onPressed: () {
                          _showSummaryContainer();
                        },
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

  _showSummaryContainer() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Order Summary'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'You will be charged \$${userProvider.userModel!.totalCartPrice! / 100} upon delivery!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                            color: Style.Colors.mainColor,
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Style.Colors.mainColor,
                            fontSize: 15,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Can't be empty";
                            } else if (value.length > 25) {
                              return "Cant be more than 25 letters";
                            } else
                              return null;
                          },
                          controller: _orderSummaryController,
                          decoration: InputDecoration(
                            labelText:
                                '  Leave a short description for your order',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              color: Style.Colors.mainColor,
                            ),
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Style.Colors.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              var uuid = Uuid();
                              String id = uuid.v4();
                              _orderServices.createOrder(
                                  userId: userProvider.user!.uid,
                                  id: id,
                                  description: _orderSummaryController.text,
                                  status: "complete",
                                  totalPrice:
                                      userProvider.userModel!.totalCartPrice,
                                  cart: userProvider.userModel!.cart);
                              for (CartItemModel cartItem 
                                  in userProvider
                                      .userModel!.cart ?? [] ) {
                                bool value = await userProvider
                                    .removeFromCart(
                                        cartItem: cartItem);
                                if (value) {
                                  userProvider.reloadUserModel();
                                  print("Item added to cart");
                                 Fluttertoast.showToast(msg: "Removed from Cart");
                                } else {
                                  print("ITEM WAS NOT REMOVED");
                                }
                              }
                              Fluttertoast.showToast(msg: "Succeffuly Ordered");
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Just add a short descrption!!");
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Style.Colors.greenColor,
                            ),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Style.Colors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
                    userProvider.reloadUserModel();
                    Fluttertoast.showToast(
                        msg: "Succesfully removed an item from your cart");
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
