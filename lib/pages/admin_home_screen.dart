import 'package:ecommerce_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/style/theme.dart' as Style;

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/image/splash.jpg"),
            )),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overall\nDaily Progress",
              style: TextStyle(color: Style.Colors.secondColor, fontSize: 12),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Welcome Lewiz!",
                style:
                    TextStyle(color: Style.Colors.secondColor, fontSize: 14.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Style.Colors.mainColor,
      elevation: 0,
      title: Text(
        "Admin Dashboard",
        style: TextStyle(color: Style.Colors.secondColor, fontSize: 18),
      ),
      centerTitle: true,
    );
  }
}
