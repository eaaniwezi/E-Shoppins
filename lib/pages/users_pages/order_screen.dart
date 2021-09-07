import 'package:ecommerce_app/model/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/providers/users_providers/user_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: userProvider.orders.length == 0
          ? _emptyOrderContainer()
          : _orderContainer(),
    );
  }

  _orderContainer() {
    final userProvider = Provider.of<UserProvider>(context);

    return ListView.builder(
      itemCount: userProvider.orders.length,
      itemBuilder: (_, index) {
        OrderModel _order = userProvider.orders[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            constraints: BoxConstraints(
              maxHeight: 90,
              // maxWidth: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Costs: ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Style.Colors.secondColor,
                      ),
                    ),
                    Text(
                      "\$${_order.totalPrice! / 100}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Order-Description: ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Style.Colors.secondColor,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * .5,
                        child: Text(
                          _order.description.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Date:  ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Style.Colors.secondColor,
                      ),
                    ),
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(_order.createdAt ?? 0)
                          .toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status:  ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Style.Colors.secondColor,
                      ),
                    ),
                    Text(
                      _order.status.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Style.Colors.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _emptyOrderContainer() {
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
                  image: AssetImage('images/image/order.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Text("You haven't ordered from us yet"),
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
            "Your Order(s)",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            userProvider.orders.length == 0
                ? ""
                : userProvider.orders.length == 1
                    ? "${userProvider.orders.length} order(s)"
                    : "${userProvider.orders.length} orders"
                        .toString(), // "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
