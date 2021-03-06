import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import './widgets/ft_course_list.dart';
import '../../constants.dart' as Constants;
import '../../utils/custom_tab_indicator.dart';
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
          elevation: 0,
          actions: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('courses').snapshots(),
              builder: (context, snapshot) {
                print(snapshot.data.documents);
                if (snapshot == null) {}
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
            labelStyle: GoogleFonts.lato(fontSize: 24),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Color(0xffbabbbc),
            indicator: CustomTabIndicator(
              indicatorColor: Theme.of(context).scaffoldBackgroundColor,
              indicatorHeight: 3,
            ),
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

