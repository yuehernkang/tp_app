import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp_app/courses_page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name) {
      case CoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => CoursesPage());
    }
  }
}