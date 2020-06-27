import 'package:auto_size_text/auto_size_text.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tp_app/home_page/models/highlight_object.dart';
import 'package:tp_app/ui/map_page/flutter_map_page.dart';
import 'package:tp_app/ui/map_page/map_page.dart';
import 'package:tp_app/ui/map_page/mapbox_page.dart';

import '../repository/authentication_bloc/authentication_bloc.dart';
import '../ui/app_bar/custom_app_bar.dart';
import '../ui/chat/chat_page.dart';
import '../ui/drawer/tp_drawer.dart';
import '../ui/full_time_courses/ft_courses_page.dart';
import '../ui/part_time_courses/pt_courses_page.dart';
import '../ui/scholarships/scholarship_page.dart';
import 'highlights_slideshow_widget.dart';
import './menu_page.dart';

class MyHomePage extends StatefulWidget {
  static List<MenuItem> mainMenu = [
    MenuItem("payment", Icons.payment, 0),
    MenuItem("promos", Icons.card_giftcard, 1),
    MenuItem("notifications", Icons.notifications, 2),
    MenuItem("help", Icons.help, 3),
    MenuItem("about_us", Icons.info_outline, 4),
  ];

  static const String routeName = "/";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _updatePage(index) {
    print("index");
  }

  @override
  Widget build(BuildContext context) {
    final _drawerController = ZoomDrawerController();
    int _currentPage = 0;
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: BlocProvider.value(
        value: authenticationBloc,
        child: TpDrawer(context: context),
      ),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[BodyContainer()],
        ),
      ),
    );
  }
}

class BodyContainer extends StatelessWidget {
  const BodyContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<HighlightObject> imageUrlList = List();
    imageUrlList.add(HighlightObject(
        highlightImageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Carousel/TSA-ETSP.jpg",
        targetUrl:
            "https://www.tp.edu.sg/staticfiles/TP/files/centres/tsa/ETSP_for_4_Sectors_Brochure.pdf"));
    imageUrlList.add(HighlightObject(
        highlightImageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/Web/Carousel/kickstarter-thumbnail.jpg",
        targetUrl:
            "https://www.tp.edu.sg/staticfiles/Review/careerkickstarter/careerkickstarter.pdf"));
    imageUrlList.add(HighlightObject(
        highlightImageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Carousel/freshmen-2020.jpg",
        targetUrl: "https://www.tp.edu.sg/admissions/freshmen"));
    imageUrlList.add(HighlightObject(
        highlightImageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Banners/BYOD.jpg",
        targetUrl: "https://www.tp.edu.sg/byod"));
    imageUrlList.add(HighlightObject(
        highlightImageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/Web/Carousel/tp30_carousel_banner.jpg",
        targetUrl: "https://www.tp.edu.sg/30"));
    return Column(
      children: <Widget>[
        Card(
          // elevation: 12.0,
          child: Column(
            children: <Widget>[
              TitleContainer(title: "Latest Highlights"),
              HighlightsSlideshow(imageUrlList: imageUrlList),
            ],
          ),
        ),
        Card(
          // elevation: 12.0,
          child: Column(
            children: <Widget>[
              TitleContainer(title: "Prospective Students"),
              RowOneIconContainer(),
              RowTwoIconContainer(),
              RowThreeIconContainer(),
              RowFourIconContainer(),
            ],
          ),
        ),
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
        style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w600),
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
            icon: FaIcon(
              FontAwesomeIcons.school,
              size: 50.0,
              color: Colors.red,
            ),
            subtitle: "Full-Time Courses",
          ),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(
                FontAwesomeIcons.graduationCap,
                size: 50.0,
                color: Colors.yellowAccent,
              ),
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
              icon: FaIcon(
                FontAwesomeIcons.briefcase,
                size: 50.0,
                color: Colors.blue,
              ),
              subtitle: "Part-Time Courses"),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(
                FontAwesomeIcons.comments,
                size: 50.0,
                color: Colors.orange,
              ),
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

class RowFourIconContainer extends StatelessWidget {
  const RowFourIconContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconWithSubtitle(
            icon: FaIcon(
              FontAwesomeIcons.map,
              size: 50.0,
              color: Colors.blue,
            ),
            subtitle: "Map",
          ),
        ),
        Expanded(
          child: IconWithSubtitle(
              icon: FaIcon(FontAwesomeIcons.toolbox, size: 50.0),
              subtitle: "NOT"),
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
              break;
            case "Map":
              {
                Navigator.pushNamed(context, MapboxPage.routeName);
              }
          }
        },
        child: Column(
          children: <Widget>[
            this.icon,
            Center(
              child: AutoSizeText(
                this.subtitle,
                maxLines: 1,
                style: GoogleFonts.lato(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
