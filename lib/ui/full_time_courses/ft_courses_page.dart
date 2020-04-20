import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';

import '../../models/course.dart';
import '../app_bar/custom_app_bar.dart';
import 'ft_courses_detail.dart';

class FtCoursesPage extends StatefulWidget {
  const FtCoursesPage({Key key}) : super(key: key);
  static const String routeName = "/ftCoursesPage";

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

enum Schools {
  AppliedScience,
  Business,
  Design,
  Engineering,
}

class _CoursesPageState extends State<FtCoursesPage>
    with SingleTickerProviderStateMixin {
  String dropdownValue = 'Business';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropDownButtons = DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      // icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Theme.of(context).accentColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          print(newValue);
          dropdownValue = newValue;
        });
      },
      items: <String>['Business', 'Design', 'Engineering', 'Applied Science']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: Theme.of(context).textTheme.subtitle),
        );
      }).toList(),
    );

    Future _loadCourseAsset() async {
      print("loading course");
      if (dropdownValue == 'Business') {
        return await rootBundle.loadString("assets/business.json");
      } else if (dropdownValue == 'Engineering') {
        return await rootBundle.loadString("assets/engineering.json");
      } else if (dropdownValue == 'Applied Science') {
        return await rootBundle.loadString("assets/asc.json");
      }
    }

    Future loadCourse() async {
      String jsonString = await _loadCourseAsset();
      final jsonResponse = json.decode(jsonString);
      // print(jsonResponse);
      return jsonResponse;
    }

    final coursesContainer = FutureBuilder(
        future: loadCourse(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return CourseList(courses: snapshot.data);
          }
        });

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            dropDownButtons,
            Expanded(
              child: BookList(
                school: dropdownValue.toLowerCase(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookList extends StatelessWidget {
  final String school;
  BookList({this.school});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('courses')
          .document(this.school)
          .collection('courseList')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            print(snapshot.data.metadata.isFromCache
                ? "NOT FROM NETWORK"
                : "FROM NETWORK");
            return new ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoursesDetail(
                                course: Course.fromSnapshot(document))));
                  },
                  child: FTCourseCard(course: Course.fromSnapshot(document)),
                );
              }).toList(),
            );
        }
      },
    );
  }
}

class CourseList extends StatelessWidget {
  final List<dynamic> courses;
  final DocumentSnapshot snapshot;
  CourseList({Key key, this.courses, this.snapshot}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  duration: const Duration(milliseconds: 375),
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoursesDetail(
                                      course:
                                          Course.fromJson(courses[index]))));
                        },
                        child: FTCourseCard(
                            // courseName: courses[index]['courseName'],
                            // courseCode: courses[index]['courseCode'],
                            // localImagePath: courses[index]['image'],
                            // imageUrl: courses[index]['imageUrl'],
                            ),
                      ),
                    ),
                  ));
            }));
  }
}

class FTCourseCard extends StatelessWidget {
  final Course course;
  const FTCourseCard({Key key, this.course
      // this.courseName,
      // this.courseCode,
      // this.localImagePath,
      // this.imageUrl
      })
      : super(key: key);

  // final String courseName, courseCode, localImagePath, imageUrl;

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
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 2.0),
                child: Text(
                  this.course.courseName,
                  style: Theme.of(context).primaryTextTheme.headline,
                  textAlign: TextAlign.left,
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
