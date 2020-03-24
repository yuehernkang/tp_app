import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp_app/ui/part_time_courses/pt_skillsfuture/pt_skillsfuture_page.dart';
import 'package:tp_app/ui/scholarships/scholarship_page.dart';
import 'ui/chat/chat_page.dart';
import 'ui/full_time_courses/ft_courses_page.dart';
import 'ui/part_time_courses/pt_courses_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case FtCoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => FtCoursesPage());
      case ScholarshipPage.routeName:
        return MaterialPageRoute(builder: (_) => ScholarshipPage());
      case PtCoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => PtCoursesPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (_) => ChatPageHtml());
      case PtSkillsFuture.routeName:
        return MaterialPageRoute(builder: (_) => PtSkillsFuture());
    }
  }
}
