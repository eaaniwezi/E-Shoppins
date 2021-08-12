import 'package:ecommerce_app/home_page.dart';
import 'package:ecommerce_app/pages/users_pages/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class ProductDetailsScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final product_details_name;
  // ignore: non_constant_identifier_names
  final product_details_current_price;
  // ignore: non_constant_identifier_names
  final product_details_old_price;
  // ignore: non_constant_identifier_names
  final product_details_picture;
  // ignore: non_constant_identifier_names
  final product_details_description;
  // ignore: non_constant_identifier_names
  final product_details_color;
  // ignore: non_constant_identifier_names
  final other_pictures;
  const ProductDetailsScreen({
    Key? key,
    // ignore: non_constant_identifier_names
    this.product_details_name,
    // ignore: non_constant_identifier_names
    this.product_details_current_price,
    // ignore: non_constant_identifier_names
    this.product_details_old_price,
    // ignore: non_constant_identifier_names
    this.product_details_picture,
    // ignore: non_constant_identifier_names
    this.product_details_description,
    // ignore: non_constant_identifier_names
    this.product_details_color,
    // ignore: non_constant_identifier_names
    this.other_pictures,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
              widget.product_details_name,
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
              widget.product_details_description,
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
                _productSize(),
                _productsColors(),
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
            widget.product_details_color.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 2),
                padding: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Style.Colors.secondColor
                          .withOpacity(selectedColor == index ? 1 : 0)),
                  shape: BoxShape.circle,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.product_details_color[index],
                    shape: BoxShape.circle,
                  ),
                ),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
        },
      ),
      backgroundColor: Style.Colors.mainColor,
      actions: [
        // new IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        new IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            }, icon: Icon(Icons.shopping_cart_outlined)),
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
        SizedBox(
          //  width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product_details_name,
              child: Image.asset(
                widget.other_pictures[selectedImage],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(widget.other_pictures.length,
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
      child: AnimatedContainer(
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
        child: Image.asset(
          widget.other_pictures[index],
          fit: BoxFit.cover,
        ),
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
