import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final imageHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.redAccent, //change your color here
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Image.asset('assets/TP_Main.jpg', height: kToolbarHeight),
      elevation: 0,
    );
  }

  @override
  final Size preferredSize;
}
