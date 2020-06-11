import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CoursesDetail2 extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String documentID;
  CoursesDetail2({Key key, this.snapshot, this.documentID}) : super(key: key);

  @override
  _CoursesDetailState createState() => _CoursesDetailState();
}

class _CoursesDetailState extends State<CoursesDetail2> {
  DocumentSnapshot snapshot;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PlatformScaffold(
            body: SingleChildScrollView(
                child: CourseDetailBody(snapshot: widget.snapshot))));
  }
}

class CourseDetailBody extends StatelessWidget {
  const CourseDetailBody({
    Key key,
    @required this.snapshot,
  }) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.yellow])),
      child: Column(
        children: <Widget>[
          CourseNameWidget(
            courseName: snapshot["courseName"],
          ),
          CourseDetailWidget(
            courseDetailText: snapshot["courseDetails"],
          ),
          CourseDetailWidget(
            courseDetailText: snapshot["courseDetails"],
          ),
          CourseDetailWidget(
            courseDetailText: snapshot["courseDetails"],
          ),
        ],
      ),
    );
  }
}

class CourseNameWidget extends StatelessWidget {
  final String courseName;
  CourseNameWidget({this.courseName});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AutoSizeText(
      courseName ?? 'Course Name',
      minFontSize: 56,
      maxFontSize: 80,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}

class CourseDetailWidget extends StatelessWidget {
  final String courseDetailText;
  const CourseDetailWidget({Key key, this.courseDetailText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(fontSize: 32, color: Colors.grey),
            ),
            Text(
              this.courseDetailText,
              style: TextStyle(height: 1.5, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class CourseHighlightsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child: Column(
          children: <Widget>[
            Text(
              "Course Details",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Hello",
              style: TextStyle(height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}
