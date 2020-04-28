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
  String dropdownValue;
  double width;

  Widget _categoryRow(String title) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
//              width: width,
//              height: 40,
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 20),
              _chip(schools[0], Colors.yellowAccent, height: 5),
              SizedBox(width: 10),
              _chip(schools[1], Colors.purpleAccent, height: 5),
              SizedBox(width: 10),
              _chip(schools[2], Colors.white, height: 5),
              SizedBox(width: 10),
              _chip(schools[3], Colors.white, height: 5),
            ],
          )),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _chip(School school, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          dropdownValue = school.value;
        });
        print(school.value);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(15)),
//        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
//      ),
        child: Text(
          school.displayName,
          style: TextStyle(
//            color: isPrimaryCard ? Colors.white : textColor,
              color: Colors.white,
              fontSize: 24),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    dropdownValue = schools[0].value;
  }

  @override
  Widget build(BuildContext context) {
//    final dropDownButtons = DropdownButton<String>(
//      isExpanded: true,
//      value: dropdownValue.value,
//      // icon: Icon(Icons.arrow_downward),
//      iconSize: 24,
//      elevation: 16,
//      style: TextStyle(color: Colors.black),
//      underline: Container(
//        height: 2,
//        color: Theme.of(context).accentColor,
//      ),
//      onChanged: (String newValue) {
//        setState(() {
//          print(newValue);
//          dropdownValue.value = newValue;
//        });
//      },
//      items: <School>[
//        School('Business', 'business'),
//        School('Design', 'design'),
//        School('Engineering', 'engineering'),
//        School('Applied Science', 'applied_science'),
//        School('Information Technology', 'it')
//      ].map<DropdownMenuItem<String>>((School value) {
//        return DropdownMenuItem<String>(
//          value: value.value,
//          child: Text(value.displayName,
//              style: Theme.of(context).textTheme.subtitle),
//        );
//      }).toList(),
//    );

//    Future _loadCourseAsset() async {
//      print("loading course");
//      if (dropdownValue == 'Business') {
//        return await rootBundle.loadString("assets/business.json");
//      } else if (dropdownValue == 'Engineering') {
//        return await rootBundle.loadString("assets/engineering.json");
//      } else if (dropdownValue == 'Applied Science') {
//        return await rootBundle.loadString("assets/asc.json");
//      }
//    }
//
//    Future loadCourse() async {
//      String jsonString = await _loadCourseAsset();
//      final jsonResponse = json.decode(jsonString);
//      // print(jsonResponse);
//      return jsonResponse;
//    }
//
//    final coursesContainer = FutureBuilder(
//        future: loadCourse(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return CircularProgressIndicator();
//          } else {
//            return CourseList(courses: snapshot.data);
//          }
//        });

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            _categoryRow("Select Your School"),
            // dropDownButtons,
            Expanded(
              child: BookList(
                school: dropdownValue,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TPFullTimeBottomNav(),
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
          .orderBy('courseName')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return CircularProgressIndicator();
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
                                          course: Course.fromSnapshot(snapshot
                                              .data.documents[index]))));
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
