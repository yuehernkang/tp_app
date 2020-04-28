import 'package:cloud_firestore/cloud_firestore.dart';

class Course{
  String courseName, courseCode, courseDetails, image, year1, year2, year3;

  Course({this.courseCode, this.courseName, this.courseDetails, this.image, this.year1, this.year2, this.year3});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseCode: json['courseCode'] as String,
      courseName: json['courseName'] as String,
      courseDetails: json['courseDetails'] as String,
      image: json['image'] as String,
      year1: json['year1'] as String,
      year2: json['year2'] as String,
      year3: json['year3'] as String
    );
  }

  factory Course.fromSnapshot(DocumentSnapshot snapshot){
    return Course(
      courseCode: snapshot.data['courseCode'],
      courseName: snapshot.data['courseName'],
      courseDetails: snapshot.data['courseDetails'],
      image: snapshot.data['imageUrl'],
      year1: snapshot.data['year1'],
      year2: snapshot.data['year2'],
      year3: snapshot.data['year3']
    );
  }

}

// class CourseList {
//   final List<Course> courses;
//   CourseList({this.courses});

//   factory CourseList.fromJson(List<dynamic> parsedJson) {
//     List<Course> courses = new List<Course>();
//     courses = parsedJson.map((e) => Course.fromJson(e)).toList();
//     return new CourseList(
//       courses: courses
//     );
//   }
// }