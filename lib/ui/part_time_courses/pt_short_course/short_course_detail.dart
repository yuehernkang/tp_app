import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShortCourseDetailPage extends StatelessWidget {
  static const String routeName = "/ptShortCourseDetail";
  final String categoryName;

  const ShortCourseDetailPage({Key key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.categoryName)),
      body: ShortCourseList(categoryName: this.categoryName),
    );
  }
}

class ShortCourseList extends StatelessWidget {
  final categoryName;

  const ShortCourseList({Key key, this.categoryName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance
          .collection("pt_short_courses")
          .where("category_name", isEqualTo: this.categoryName)
          .getDocuments(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new SpinKitFadingFour(
              color: Colors.white,
              size: 50.0,
            );
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['course_name']),
                  subtitle: new Text(document['category_name']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
