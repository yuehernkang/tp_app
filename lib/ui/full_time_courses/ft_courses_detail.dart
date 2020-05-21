import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tp_app/models/course.dart';

import 'ft_courses_modules_page.dart';

class CoursesDetail extends StatefulWidget {
  // final Course course;
  final DocumentSnapshot snapshot;
  final String documentID;
  CoursesDetail({Key key, this.snapshot, this.documentID}) : super(key: key);

  @override
  _CoursesDetailState createState() => _CoursesDetailState();
}

class _CoursesDetailState extends State<CoursesDetail> {
  DocumentSnapshot snapshot;
  Widget yearCard(String title, String details) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width * 0.90,
      child: InkWell(
        onTap: () {},
        child: Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              title: Text(
                title,
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text(details),
            )
          ],
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot == null) {
      print("snapshot is null");
      return FutureBuilder(
        future: Firestore.instance
            .collection("courses")
            .document(widget.documentID)
            .get(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot dsnapshot) {
          if (!dsnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Widget> yearList = List<Widget>(3);
          yearList[0] = yearCard("Year 1", dsnapshot.data['year1']);
          yearList[1] = yearCard("Year 2", dsnapshot.data['year2']);
          yearList[2] = yearCard("Year 3", dsnapshot.data['year3']);
          return CourseDetailBody(
            snapshot: dsnapshot.data,
            yearList: yearList,
          );
        },
      );
    }
    print("snapshot is not null");
    List<Widget> yearList = List<Widget>(3);
    yearList[0] = yearCard("Year 1", widget.snapshot.data['year1']);
    yearList[1] = yearCard("Year 2", widget.snapshot.data['year2']);
    yearList[2] = yearCard("Year 3", widget.snapshot.data['year3']);
    return CourseDetailBody(
      snapshot: widget.snapshot,
      yearList: yearList
    );
  }
}

class CourseDetailBody extends StatelessWidget {
  const CourseDetailBody({
    Key key,
    @required this.snapshot,
    @required this.yearList,
  }) : super(key: key);

  final DocumentSnapshot snapshot;
  final List<Widget> yearList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        snapshot.data['courseName'],
        style: Theme.of(context).primaryTextTheme.headline,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CourseHeroImageWidget(
              course: Course.fromSnapshot(snapshot),
            ),
            CourseDetailWidget(
                courseDetailText: snapshot.data['courseDetails']),
            PlatformButton(
              child: PlatformText("View Course Modules"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FtCoursesModulePage(
                              snapshot: snapshot,
                            )));
              },
            ),
            ThreeYearWidget(widgetList: yearList)
          ],
        ),
      ),
    );
  }
}

class CourseHeroImageWidget extends StatelessWidget {
  final Course course;
  const CourseHeroImageWidget({Key key, this.course});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: course.courseCode,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: CachedNetworkImage(imageUrl: course.image),
        ),
      ),
    );
  }
}

class CourseDetailWidget extends StatelessWidget {
  final courseDetailText;
  const CourseDetailWidget({Key key, this.courseDetailText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              "Course Details",
              style: TextStyle(fontSize: 24),
            ),
            ExpandText(
              this.courseDetailText,
              textAlign: TextAlign.justify,
              maxLength: 5,
            ),

            // ReadMoreText(
            //   widget.course.courseDetails,
            //   trimLines: 3,
            //   colorClickableText: Colors.pink,
            //   trimMode: TrimMode.Line,
            //   trimCollapsedText: '...Expand',
            //   trimExpandedText: ' Collapse ',
            //   style: TextStyle(fontSize: 16),
            // )
          ],
        ),
      ),
    );
  }
}

class ThreeYearWidget extends StatelessWidget {
  final widgetList;
  const ThreeYearWidget({Key key, this.widgetList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width * 0.90,
                child: Swiper(
                  loop: false,
                  index: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return this.widgetList[index];
                  },
                  itemCount: 3,
                  viewportFraction: 0.8,
                  scale: 1,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ThreeYearsCard extends StatelessWidget {
  final String year1, year2, year3;

  const ThreeYearsCard({Key key, this.year1, this.year2, this.year3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: Text(
        "3 years",
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      children: <Widget>[],
    );
  }
}

class CourseDetailExpandCard extends StatelessWidget {
  final String title, details;

  const CourseDetailExpandCard({Key key, this.title, this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: Text(
        this.title,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(this.details),
        )
      ],
    );
  }
}
