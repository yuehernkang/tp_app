import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tp_app/courses_detail.dart';
import 'dart:convert';
import 'package:tp_app/models/course.dart';

import 'helper/quad_clipper.dart';
import 'theme/color/light_color.dart';

class CoursesPage extends StatefulWidget {
  static const String routeName = "/coursesPage";
  const CoursesPage({Key key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

enum Schools {
  AppliedScience,
  Business,
  Design,
  Engineering,
}

class _CoursesPageState extends State<CoursesPage>
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
        color: Colors.redAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Business', 'Design', 'Engineering', 'Applied Science']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
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
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            dropDownButtons,
            Container(
              height: MediaQuery.of(context).size.height - 148,
              child: Center(
                child: coursesContainer,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final List<dynamic> courses;
  CourseList({Key key, this.courses}) : super(key: key);
  double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoursesDetail(
                            course: Course.fromJson(courses[index]))));
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: courses[index]['courseCode'],
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Image.network(courses[index]['image']),
                        ),
                      ),
                    ),
                    Text(
                      courses[index]['courseName'],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
