import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../models/course.dart';
import '../app_bar/custom_app_bar.dart';
import 'bottomNav.dart';
import 'ft_courses_detail.dart';

class FtCoursesPage extends StatefulWidget {
  const FtCoursesPage({Key key}) : super(key: key);
  static const String routeName = "/ftCoursesPage";

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class School {
  School(this.displayName, this.value);

  String displayName, value;
}

class _CoursesPageState extends State<FtCoursesPage>
    with SingleTickerProviderStateMixin {
  List<School> schools = [
    School('Business', 'business'),
    School('Design', 'design'),
    School('Engineering', 'engineering'),
    School('Applied Science', 'applied_science'),
    School('Information Technology', 'it')
  ];
  double width;
  PlatformTabController tabController;
  void initState() {
    super.initState();
    if (tabController == null) {
      tabController = PlatformTabController(
        initialIndex: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = (BuildContext context) => [
          BottomNavigationBarItem(
            title: Text("Favourite Courses"),
            icon: Icon(context.platformIcons.flag),
          ),
          BottomNavigationBarItem(
            title: Text("All Courses"),
            icon: Icon(context.platformIcons.book),
          ),
        ];

    final tabItems = [
      Tab(
        text: "Business",
      ),
      Tab(
        text: "Engineering",
      ),
      Tab(
        text: "Design",
      ),
      Tab(
        text: "Applied Science",
      ),
      Tab(
        text: "IT",
      )
    ];

    final tabContent = [
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: 'bus',
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: 'eng',
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: 'des',
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: 'asc',
              ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: 'iit',
              ),
            )
          ],
        ),
      ),
    ];

    return PlatformScaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            title: Image.asset('assets/tplogo.png', height: kToolbarHeight),
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Color(0xff5f6368),
              indicator: MD2Indicator(
                  indicatorHeight: 3,
                  indicatorColor: Theme.of(context).accentColor,
                  indicatorSize: MD2IndicatorSize.full),
              tabs: tabItems,
            ),
          ),
          body: TabBarView(
            children: tabContent,
          ),
          bottomNavigationBar: TPFullTimeBottomNav(),
        ),
      ),
    );
  }
}

class FTCourseList extends StatelessWidget {
  final String school;
  FTCourseList({this.school});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('courses')
            .document(this.school)
            .collection('courseList')
            .orderBy('courseName')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              print(snapshot.data.metadata.isFromCache
                  ? "NOT FROM NETWORK"
                  : "FROM NETWORK");
              return AnimationLimiter(
                child: Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 500),
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 120.0,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoursesDetail(
                                              snapshot: snapshot
                                                  .data.documents[index],
                                            )));
                              },
                              child: FTCourseCard(
                                  course: Course.fromSnapshot(
                                      snapshot.data.documents[index])),
                            ),
                          ));
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class FTCourseCard extends StatelessWidget {
  final Course course;
  const FTCourseCard({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: this.course.image,
                      placeholder: (image, ctx) => Container(
                          width: 800,
                          child: AspectRatio(
                            aspectRatio: 1900 / 783,
                            child:
                                BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                          )),
                    ),
                    // child: Image.asset(
                    //     this.localImagePath),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                  child: Text(
                    this.course.courseName,
                    style: Theme.of(context).primaryTextTheme.headline,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              LikeButton(
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Theme.of(context).buttonColor,
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
