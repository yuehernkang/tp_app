import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_app/repository/bloc/authentication_bloc.dart';
import 'package:tp_app/ui/login_page/login_with_password.dart';
import 'package:tp_app/ui/part_time_courses/pt_skillsfuture/pt_skillsfuture_page.dart';
import 'package:tp_app/ui/scholarships/scholarship_page.dart';
import 'home_page/home_page.dart';
import 'repository/UserRepository.dart';
import 'ui/chat/chat_page.dart';
import 'ui/full_time_courses/ft_courses_page.dart';
import 'ui/part_time_courses/pt_courses_page.dart';

class AppRouter {
  final _authenticationBloc = AuthenticationBloc(userRepository: UserRepository());
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authenticationBloc,
                  child: MyHomePage(),
                ));
      case FtCoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => FtCoursesPage());
      case ScholarshipPage.routeName:
        return MaterialPageRoute(builder: (_) => ScholarshipPage());
      case PtCoursesPage.routeName:
        return MaterialPageRoute(builder: (_) => PtCoursesPage());
      case ChatPage.routeName:
        return MaterialPageRoute(builder: (_) => ChatPage());
      case PtSkillsFuture.routeName:
        return MaterialPageRoute(builder: (_) => PtSkillsFuture());
      case LoginWithPassword.routeName:
        return MaterialPageRoute(builder: (_) => LoginWithPassword());
    }
  }
}
