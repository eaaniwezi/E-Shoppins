import 'package:ecommerce_app/widgets/featured_image_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;
import 'package:ecommerce_app/providers/users_providers/product_providers.dart';

class FeaturedProductsBuilder extends StatefulWidget {
  const FeaturedProductsBuilder({Key? key}) : super(key: key);

  @override
  _FeaturedProductsBuilderState createState() =>
      _FeaturedProductsBuilderState();
}

class _FeaturedProductsBuilderState extends State<FeaturedProductsBuilder>
    with SingleTickerProviderStateMixin {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    final productProvider =
        Provider.of<UsersProductProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = pageController.page!.round() + 1;

      if (nextPage == productProvider.products.length) {
        nextPage = 0;
      }

      pageController
          .animateToPage(nextPage,
              duration: Duration(seconds: 3), curve: Curves.fastOutSlowIn)
          .then((_) => _animateSlider());
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // @override
  // void initState() {
  //   final productProvider =
  //       Provider.of<UsersProductProvider>(context, listen: false);
  //   super.initState();
  //   if (pageController.hasClients) {
  //     if (pageController.page!.round() == productProvider.products.length + 1) {
  //       pageController.animateToPage(
  //         0,
  //         duration: Duration(seconds: 2),
  //         curve: Curves.fastOutSlowIn,
  //       );
  //     } else {
  //       pageController.nextPage(
  //           duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<UsersProductProvider>(context, listen: false);
    return Container(
      height: 220,
      child: productProvider.featuredProducts.length > 0
          ? PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: productProvider.featuredProducts.length,
              indicatorSpace: 8,
              padding: const EdgeInsets.all(5),
              indicatorColor: Style.Colors.titleColor,
              indicatorSelectorColor: Style.Colors.secondColor,
              shape: IndicatorShape.circle(size: 5),
              child: PageView(
                allowImplicitScrolling: false,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: productProvider.featuredProducts
                    .map((item) => GestureDetector(
                          onTap: () {},
                          child: FeaturedImageContainer(
                            productPictures: item,
                          ),
                        ))
                    .toList(),
              ),
            )
          : Center(
              child: Text(
                "No Featured Product",
                style: TextStyle(
                  color: Style.Colors.whiteColor,
                ),
              ),
            ),
    );
  }
}
