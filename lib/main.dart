import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tp_app/ui/chat/chat_page.dart';
import 'package:tp_app/ui/part_time_courses/pt_courses_page.dart';
import 'package:tp_app/ui/scholarships/scholarship_page.dart';
import 'route_generator.dart';
import 'ui/app_bar/custom_app_bar.dart';
import 'ui/full_time_courses/ft_courses_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BodyContainer(),
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
        RowTwoIconContainer()
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
              icon: FaIcon(FontAwesomeIcons.school),
              subtitle: "Full-Time Courses"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.graduationCap),
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
              icon: FaIcon(FontAwesomeIcons.briefcase),
              subtitle: "Part-Time Courses"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.comments),
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
          if (subtitle == "Full-Time Courses") {
            Navigator.pushNamed(context, FtCoursesPage.routeName);
          } else if (subtitle == "Scholarships") {
            Navigator.pushNamed(context, ScholarshipPage.routeName);
          } else if (subtitle == "Part-Time Courses") {
            Navigator.pushNamed(context, PtCoursesPage.routeName);
          }else if (subtitle == "Chat") {
            Navigator.pushNamed(context, ChatPage.routeName);
          }
          
        },
        child: Column(
          children: <Widget>[
            this.icon,
            Text(
              this.subtitle,
              style: TextStyle(fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}
