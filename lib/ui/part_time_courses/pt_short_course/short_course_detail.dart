import 'package:flutter/material.dart';

class ShortCourseDetailPage extends StatelessWidget {
  static const String routeName = "/ptShortCourseDetail";
  final String categoryName;

  const ShortCourseDetailPage({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
    );
  }
}
