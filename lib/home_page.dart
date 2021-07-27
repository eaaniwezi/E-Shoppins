import 'package:ecommerce_app/widgets/horizontal_list.dart';
import 'package:ecommerce_app/widgets/recent_products.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  List<Widget> _list = [
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/1.jpg"),
        ),
      ),
    ),
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/2.jpg"),
        ),
      ),
    ),
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/3.jpg"),
        ),
      ),
    ),
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/4.jpg"),
        ),
      ),
    ),
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/5.jpg"),
        ),
      ),
    ),
    Container(
      // width: MediaQuery.of(context).size.width,
      height: 220.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("images/image/6.png"),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = pageController.page!.round() + 1;

      if (nextPage == _list.length) {
        nextPage = 0;
      }

      pageController
          .animateToPage(nextPage,
              duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn)
          .then((_) => _animateSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('E-Shoppins'),
        backgroundColor: Style.Colors.mainColor,
        actions: [
          new IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          new IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
        ],
      ),
      drawer: new Drawer(
        child: _drawerChildren(),
      ),
      body: new ListView(
        children: [
          _imageCarousel(),
          new Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Categories",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          HorizontalList(),
             new Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Recent products",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          RecentProducts(),
        ],
      ),
    );
  }

  Widget _imageCarousel() {
    return Container(
      height: 220,
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length: 6,
        indicatorSpace: 8,
        padding: const EdgeInsets.all(5),
        indicatorColor: Style.Colors.titleColor,
        indicatorSelectorColor: Style.Colors.secondColor,
        shape: IndicatorShape.circle(size: 5),
        child: PageView(
          allowImplicitScrolling: false,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: _list,
        ),
      ),
    );
  }

  Widget _drawerChildren() {
    return new ListView(
      children: [
        new UserAccountsDrawerHeader(
          accountName: Text("Lewiz"),
          accountEmail: Text("eaaninwezi@gmail.com"),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Style.Colors.secondColor,
              ),
            ),
          ),
        ),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("My Account"),
                leading: Icon(Icons.person, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_cart_rounded,
                    color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Categories"),
                leading:
                    Icon(Icons.dashboard, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Favorites"),
                leading:
                    Icon(Icons.favorite, color: Style.Colors.secondColor))),
        Divider(),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Settings"),
                leading:
                    Icon(Icons.settings, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("Languages"),
                leading:
                    Icon(Icons.language, color: Style.Colors.secondColor))),
        InkWell(
            onTap: () {},
            child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help, color: Style.Colors.secondColor))),
      ],
    );
  }
}
