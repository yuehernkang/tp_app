import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

import '../../models/course.dart';
import '../widgets/loading_widget.dart';
import 'ft_courses_detail.dart';
import 'search_course/bloc/ft_course_search_bloc.dart';
import 'search_course/course_search_delegate.dart';
import 'search_course/repository/search_repository.dart';

class School {
  School(this.displayName, this.value);

  String displayName, value;
}

class FtCoursesPage extends StatelessWidget {
  static const String routeName = "/ftCoursesPage";
  double width;
  PlatformTabController tabController;
  @override
  Widget build(BuildContext context) {
    if (tabController == null) {
      tabController = PlatformTabController(
        initialIndex: 0,
      );
    }
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

    return PlatformTabScaffold(
      tabController: tabController,
      items: items(context),
      bodyBuilder: (context, index) => ContentView(
        index: index,
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  final index;

  const ContentView({Key key, this.index}) : super(key: key);

  @override
  _ContentViewState createState() => _ContentViewState();
}

class TabWidget extends StatelessWidget {
  final String school;
  const TabWidget({Key key, this.school}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FTCourseList(
                school: school,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ContentViewState extends State<ContentView> {
  Widget tabWidget(String school) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: FTCourseList(
              school: school,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      TabWidget(school: 'bus'),
      TabWidget(school: 'eng'),
      TabWidget(school: 'des'),
      TabWidget(school: 'asc'),
      TabWidget(school: 'iit'),
    ];
    final SearchRepository searchRepository = SearchRepository();
    final FtCourseSearchBloc _ftCourseSearchBloc =
        FtCourseSearchBloc(searchRepository);
    final coursesList = [
      PlatformScaffold(
        body: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CourseSearchDelegate(
                            ftCourseSearchBloc: _ftCourseSearchBloc),
                      );
                    })
              ],
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
            // bottomNavigationBar: TPFullTimeBottomNav(),
          ),
        ),
      ),
      Container(
        child: Text("Hello"),
      )
    ];
    return coursesList[this.widget.index];
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class FTCourseList extends StatefulWidget {
  final String school;
  FTCourseList({this.school});

  @override
  _FTCourseListState createState() => _FTCourseListState();
}

class _FTCourseListState extends State<FTCourseList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection('courses')
            .where("school", isEqualTo: this.widget.school)
            .orderBy('courseName')
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return LoadingWidget();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingWidget();
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
                              child: FTCourseCard3(
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

  @override
  bool get wantKeepAlive => true;
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
                  child: AutoSizeText(
                    this.course.courseName,
                    maxLines: 1,
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

class FTCourseCard2 extends StatelessWidget {
  final Course course;
  const FTCourseCard2({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
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
          Text(
            this.course.courseName,
            style: TextStyle(fontSize: 28),
          )
        ],
      ),
    );
  }
}

class FTCourseCard3 extends StatelessWidget {
  final Course course;
  const FTCourseCard3({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: this.course.courseCode,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: this.course.image,
                        placeholder: (image, ctx) => Container(
                            child: AspectRatio(
                          aspectRatio: 1900 / 783,
                          child: BlurHash(hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I"),
                        )),
                      ),
                      // child: Image.asset(
                      //     this.localImagePath),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 128,
              ),
              Center(
                child: AutoSizeText(
                  this.course.courseName,
                  stepGranularity: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
