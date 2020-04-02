import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
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
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => _buildTheme(brightness),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: MyHomePage(),
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData.dark().copyWith(
            cardColor: Colors.grey,
            accentColor: Colors.grey,
            primaryColor: Colors.grey,
            primaryTextTheme: TextTheme(
                headline6: TextStyle(fontSize: 24, color: Colors.white),
                subtitle1: TextStyle(fontSize: 16, color: Colors.white)),
            iconTheme: IconThemeData(color: Colors.red),
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                  fontFamily: 'Roboto',
                ),
            backgroundColor: Colors.black)
        : ThemeData.light().copyWith(
            cardColor: Colors.red,
            accentColor: Colors.red,
            primaryColor: Colors.red,
            primaryTextTheme: TextTheme(
                headline6: TextStyle(fontSize: 24, color: Colors.white),
                subtitle1: TextStyle(fontSize: 16, color: Colors.white)),
            iconTheme: IconThemeData(color: Colors.red),
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                  fontFamily: 'Roboto',
                ),
            backgroundColor: Colors.white);
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (_) => changeBrightness(),
              ),
            )
          ],
        ),
      ),
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[BodyContainer()],
      ),
    );
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
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
          } else if (subtitle == "Chat") {
            Navigator.pushNamed(context, ChatPage.routeName);
          } else if (subtitle == "Change Theme") {
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
