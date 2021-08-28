import 'package:ecommerce_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/pages/users_pages/cart_screen.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:transparent_image/transparent_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _color = "none";
  String _size = "";
  var _maxLines = 3;
  int selectedImage = 0;
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: _appBar(),
      body: ListView(
        children: [
          _productImage(),
          _productBody(),
        ],
      ),
    );
  }

  _productBody() {
    return TopRoundedContainer(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              widget.product.name.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Style.Colors.mainColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(15),
              width: 64,
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: Style.Colors.secondColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 64,
            ),
            child: Text(
              widget.product.description.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_maxLines == 3) {
                    _maxLines = 30;
                  } else {
                    _maxLines = 3;
                  }
                });
              },
              child: Row(
                children: [
                  Text(
                    _maxLines == 3 ? "See More Details" : "See Less Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Style.Colors.secondColor,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    _maxLines == 3
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                    size: 12,
                    color: Style.Colors.secondColor,
                  ),
                ],
              ),
            ),
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                // _productSize(),
                // _productsColors(),
                // Text(widget.product.colors.toString()),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select a color",
                        style: TextStyle(
                          fontSize: 15,
                          color: Style.Colors.secondColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButton<String>(
                          focusColor: Colors.pink,
                            value: _color,
                            // style: TextStyle(color: white),
                            items: widget.product.colors!
                                .map<DropdownMenuItem<String>>((value) =>
                                    DropdownMenuItem(
                                        value: value, child: Text(value)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _color = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                _addToCart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _productSize() {
    return Padding(
      padding: EdgeInsets.only(
        left: 2,
        right: 64,
      ),
      child: MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return new AlertDialog(
                  title: new Text(
                    "Size",
                    style: TextStyle(fontSize: 18),
                  ),
                  content: new Text(
                    "Please choose your correct size\nThere will be no return of goods",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    new MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Row(
          children: [
            new Text("Size"),
            SizedBox(width: 5),
            new Icon(Icons.arrow_drop_down, color: Style.Colors.secondColor)
          ],
        ),
      ),
    );
  }

  _addToCart() {
    return TopRoundedContainer(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.15,
          right: MediaQuery.of(context).size.width * 0.15,
          bottom: 40,
          top: 15,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          // ignore: deprecated_member_use
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Style.Colors.secondColor,
            onPressed: () {
              print("Added to cart");
            },
            child: Text(
              "Add To Cart",
              style: TextStyle(
                fontSize: 18,
                color: Style.Colors.mainColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _productsColors() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors!.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 2),
                padding: EdgeInsets.all(8),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Style.Colors.secondColor
                          .withOpacity(selectedColor == index ? 1 : 0)),
                  shape: BoxShape.circle,
                ),
                child: Text(widget.product.colors.toString()),
                // child: DecoratedBox(
                //   decoration: BoxDecoration(
                //     color: widget.product.colors![index],
                //     shape: BoxShape.circle,
                //   ),
                // ),
              ),
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {},
          ),
          SizedBox(width: 20),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {},
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      title: InkWell(
        child: Text('E-Shoppins'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new HomePage()));
        },
      ),
      backgroundColor: Style.Colors.mainColor,
      actions: [
        // new IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        new IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: Icon(Icons.shopping_cart_outlined)),
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back)),
    );
  }

  Widget _productImage() {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: LoadingWidget(),
              ),
            ),
            SizedBox(
              //  width: 238,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.product.pictures![selectedImage],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.product.pictures!.length,
                  (index) => buildSmallProductPreview(index))
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: LoadingWidget(),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 250),
            margin: EdgeInsets.only(right: 15),
            padding: EdgeInsets.all(0),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Style.Colors.secondColor
                      .withOpacity(selectedImage == index ? 1 : 0)),
            ),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.product.pictures![index],
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
