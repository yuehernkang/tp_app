import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:tp_app/ui/map_page/map_page.dart';

import 'home_page/home_page.dart';
import 'repository/authentication_bloc/authentication_bloc.dart';
import 'ui/chat/chat_page.dart';
import 'ui/full_time_courses/ft_courses_page.dart';
import 'ui/login_page/login_with_password.dart';
import 'ui/part_time_courses/pt_courses_page.dart';
import 'ui/part_time_courses/pt_short_course/short_course_categories.dart';
import 'ui/part_time_courses/pt_short_course/short_course_list.dart';
import 'ui/part_time_courses/pt_skillsfuture/pt_skillsfuture_page.dart';
import 'ui/scholarships/scholarship_page.dart';
import 'ui/settings/settings.dart';

class AppRouter {
  final BuildContext context;
  final AuthenticationBloc authenticationBloc;

  AppRouter(this.context, this.authenticationBloc);
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: this.authenticationBloc,
                  child: MyHomePage(),
                ));
      case FtCoursesPage.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: this.authenticationBloc,
                  child: FtCoursesPage(),
                ));
      case ScholarshipPage.routeName:
        return platformPageRoute(builder: (_) => ScholarshipPage());
      case PtCoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => PtCoursesPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case PtSkillsFuture.routeName:
        return MaterialPageRoute(builder: (_) => PtSkillsFuture());
      case LoginWithPassword.routeName:
        return MaterialPageRoute(builder: (_) => LoginWithPassword());
      case SettingsPage.routeName:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case ShortCourseCategoryPage.routeName:
        return MaterialPageRoute(builder: (_) => ShortCourseCategoryPage());
      case ShortCourseListPage.routeName:
        return MaterialPageRoute(
            builder: (_) => ShortCourseListPage(categoryName: args));
      case MapPage.routeName:
        return MaterialPageRoute(builder: (_) => MapPage());
        
    }
  }

  void dispose() {
    this.authenticationBloc.close();
  }
}
