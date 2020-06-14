import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import './widgets/ft_course_list.dart';
import '../../constants.dart' as Constants;
import 'search_course/bloc/ft_course_search_bloc.dart';
import 'search_course/course_search_delegate.dart';
import 'search_course/repository/search_repository.dart';

class FtCoursesPage extends StatelessWidget {
  static const String routeName = "/ftCoursesPage";
  double width;
  PlatformTabController tabController;
  @override
  Widget build(BuildContext context) {
    return ContentView();
  }
}

class ContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget tabWidget(String school) {
      return FTCourseList(
        school: school,
      );
    }

    final tabContent = [
      tabWidget('bus'),
      tabWidget('eng'),
      tabWidget('des'),
      tabWidget('asc'),
      tabWidget('iit'),
    ];
    final SearchRepository searchRepository = SearchRepository();
    final FtCourseSearchBloc _ftCourseSearchBloc =
        FtCourseSearchBloc(searchRepository);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('courses').snapshots(),
              builder: (context, snapshot) {
                print(snapshot.data.documents);
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CourseSearchDelegate(
                            courses: snapshot.data.documents),
                      );
                    });
              },
            )
          ],
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Image.asset('assets/tplogo.png', height: kToolbarHeight),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: GoogleFonts.lato(),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Color(0xff5f6368),
            indicator: MD2Indicator(
                indicatorHeight: 3,
                indicatorColor: Theme.of(context).accentColor,
                indicatorSize: MD2IndicatorSize.full),
            tabs: Constants.tabItems,
          ),
        ),
        body: TabBarView(
          children: tabContent,
        ),
      ),
    );
  }
}
