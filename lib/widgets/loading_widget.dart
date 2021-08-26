import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SpinKitCubeGrid(
        size: 35,
        color: Style.Colors.greenColor,
      ),
    );
  }
}