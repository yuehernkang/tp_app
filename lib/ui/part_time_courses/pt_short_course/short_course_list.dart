import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp_app/ui/part_time_courses/pt_short_course/short_course_details.dart';
import 'package:tp_app/ui/widgets/loading_widget.dart';

class ShortCourseListPage extends StatelessWidget {
  static const String routeName = "/ptShortCourseDetail";
  final String categoryName;

  const ShortCourseListPage({Key key, this.categoryName}) : super(key: key);

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
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new LoadingWidget();
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot snapshot) {
                return Card(
                  child: new ListTile(
                      title: new Text(snapshot['course_name']),
                      subtitle: new Text(snapshot['category_name']),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShortCourseDetail(
                                      snapshot: snapshot,
                                    )));
                      }),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
