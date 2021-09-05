// import 'package:ecommerce_app/model/cart.dart';
// import 'package:flutter/material.dart';
// import 'package:ecommerce_app/style/theme.dart' as Style;

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Style.Colors.secondColor,
//       appBar: buildAppBar(context),
//       bottomNavigationBar: CheckoutCard(),
//       body: CartBody(),
//     );
//   }
// }

// class CartBody extends StatefulWidget {
//   @override
//   _CartBodyState createState() => _CartBodyState();
// }

// class _CartBodyState extends State<CartBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: ListView.builder(
//         itemCount: demoCarts.length,
//         itemBuilder: (context, index) => Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Dismissible(
//             key: Key(demoCarts[index].cartproducts.name.toString()),
//             direction: DismissDirection.endToStart,
//             onDismissed: (direction) {
//               setState(() {
//                 demoCarts.removeAt(index);
//               });
//             },
//             background: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFE6E6),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 children: [Spacer(), Icon(Icons.delete_forever)],
//               ),
//             ),
//             child: CartCard(cart: demoCarts[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CartCard extends StatelessWidget {
//   const CartCard({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);

//   final Cart cart;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 88,
//             child: AspectRatio(
//               aspectRatio: 0.88,
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Image.asset(
//                   cart.cartproducts.otherPictures[0],
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     cart.cartproducts.name.toString(),
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                     maxLines: 2,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 2),
//                     padding: EdgeInsets.all(8),
//                     height: 25,
//                     width: 25,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                         color: cart.cartproducts.colors[0],
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Text.rich(
//                 TextSpan(
//                   text: "\$${cart.cartproducts.price}",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Style.Colors.secondColor),
//                   children: [
//                     TextSpan(
//                         text: " x${cart.numOfItem}",
//                         style: Theme.of(context).textTheme.bodyText1),
//                   TextSpan(
//                       text: "   XL",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// AppBar buildAppBar(BuildContext context) {
//   return AppBar(
//     centerTitle: true,
//     elevation: 0,
//     backgroundColor: Colors.white,
//     leading: IconButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: Style.Colors.secondColor,
//         )),
//     title: Column(
//       children: [
//         Text(
//           "Your Cart",
//           style: TextStyle(color: Colors.black),
//         ),
//         Text(
//           "${demoCarts.length} items",
//           style: Theme.of(context).textTheme.caption,
//         ),
//       ],
//     ),
//   );
// }

// class CheckoutCard extends StatelessWidget {
//   const CheckoutCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: 15,
//         horizontal: 30,
//       ),
//       // height: 174,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -15),
//             blurRadius: 20,
//             color: Color(0xFFDADADA).withOpacity(0.15),
//           )
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF5F6F9),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(Icons.receipt_long_rounded,
//                       color: Style.Colors.mainColor),
//                 ),
//                 Spacer(),
//                 Text(
//                   "Add voucher code",
//                   style: TextStyle(color: Style.Colors.mainColor),
//                 ),
//                 const SizedBox(width: 10),
//                 Icon(
//                   Icons.arrow_forward_ios,
//                   size: 12,
//                   color: Style.Colors.secondColor,
//                 )
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text.rich(
//                   TextSpan(
//                     text: "Total:\n",
//                     children: [
//                       TextSpan(
//                         text: "\$337.15",
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                     width: 190,
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 56,
//                       // ignore: deprecated_member_use
//                       child: FlatButton(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         color: Style.Colors.secondColor,
//                         onPressed: () {},
//                         child: Text(
//                           "Check Out",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Style.Colors.mainColor,
//                           ),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
