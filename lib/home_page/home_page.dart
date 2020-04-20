import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_app/repository/bloc/authentication_bloc.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';
import 'package:tp_app/ui/chat/chat_page.dart';
import 'package:tp_app/ui/drawer/tp_drawer.dart';
import 'package:tp_app/ui/full_time_courses/ft_courses_page.dart';
import 'package:tp_app/ui/part_time_courses/pt_courses_page.dart';
import 'package:tp_app/ui/scholarships/scholarship_page.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/";

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      drawer: TpDrawer(
          context: context, authenticationBloc: authenticationBloc),
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[BodyContainer()],
      ),
    );
  }
}

class BodyContainer extends StatelessWidget {
  const BodyContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleContainer(title: "Prospective Students"),
        RowOneIconContainer(),
        RowTwoIconContainer(),
        RowThreeIconContainer()
      ],
    );
  }
}

class TitleContainer extends StatelessWidget {
  final String title;
  const TitleContainer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        this.title,
        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ),
    );
  }
}

class RowOneIconContainer extends StatelessWidget {
  const RowOneIconContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.school, size: 50.0),
              subtitle: "Full-Time Courses"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.graduationCap, size: 50.0),
              subtitle: "Scholarships"),
        ),
        // Container(
        //   height: 40.0,
        //   width: 40.0,
        //   child: SvgPicture.asset('assets/scholarship.svg'),
        // )
      ],
    );
  }
}

class RowTwoIconContainer extends StatelessWidget {
  const RowTwoIconContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.briefcase, size: 50.0),
              subtitle: "Part-Time Courses"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.comments, size: 50.0),
              subtitle: "Chat"),
        ),
        // Container(
        //   height: 40.0,
        //   width: 40.0,
        //   child: SvgPicture.asset('assets/scholarship.svg'),
        // )
      ],
    );
  }
}

class RowThreeIconContainer extends StatelessWidget {
  const RowThreeIconContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.toolbox, size: 50.0),
              subtitle: "Change Theme"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.toolbox, size: 50.0),
              subtitle: "Clear Cache"),
        ),
      ],
    );
  }
}

class IconWithSubtitle extends StatelessWidget {
  final String subtitle;
  final FaIcon icon;

  const IconWithSubtitle({Key key, this.icon, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: OutlineButton(
        borderSide: BorderSide.none,
        onPressed: () {
          switch (subtitle) {
            case "Full-Time Courses":
              {
                Navigator.pushNamed(context, FtCoursesPage.routeName);
              }
              break;
            case "Scholarships":
              {
                Navigator.pushNamed(context, ScholarshipPage.routeName);
              }
              break;

            case "Part-Time Courses":
              {
                Navigator.pushNamed(context, PtCoursesPage.routeName);
              }
              break;

            case "Chat":
              {
                Navigator.pushNamed(context, ChatPage.routeName);
              }
              break;
            case "Change Theme":
              {
                showDialog<void>(
                    context: context,
                    builder: (context) {
                      return BrightnessSwitcherDialog(
                        onSelectedTheme: (brightness) {
                          DynamicTheme.of(context).setBrightness(brightness);
                          Navigator.pop(context);
                        },
                      );
                    });
              }
              break;
            case "Clear Cache":
              {
                DefaultCacheManager().emptyCache();
              }
          }
        },
        child: Column(
          children: <Widget>[
            this.icon,
            Center(
              child: Text(
                this.subtitle,
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
