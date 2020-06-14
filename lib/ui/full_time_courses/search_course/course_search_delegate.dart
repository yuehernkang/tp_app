import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../ft_courses_detail_2.dart';

class CourseSearchDelegate extends SearchDelegate {
  final List<DocumentSnapshot> courses;
  CourseSearchDelegate({this.courses});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // @override
  // Widget buildResults(BuildContext context) {
  // print(query);
  // this.ftCourseSearchBloc.add(FtCourseSearchEvent(query));
  // return BlocBuilder(
  //   bloc: this.ftCourseSearchBloc,
  //   builder: (BuildContext context, FtCourseSearchState state) {
  //     if (state.isLoading) {
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }
  //     if (state.hasError) {
  //       return Container(
  //         child: Text('error'),
  //       );
  //     }
  //     return ListView.builder(
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text(state.courses[index].courseName),
  //         );
  //       },
  //       itemCount: state.courses.length,
  //     );
  //   },
  // );
  // }

  Widget buildSuggestions(BuildContext context) {
    List<DocumentSnapshot> items = this.courses.where((snapshot) {
      return (snapshot['courseName'] as String)
              .toUpperCase()
              .contains(query.toUpperCase()) ||
          snapshot['courseCode'].contains(query.toUpperCase());
    }).toList()
      ..sort((a, b) {
        if (a['courseName'] == query.toUpperCase()) return -1;
        if (b['courseCode'] == query.toUpperCase()) return 1;
        return 0;
      });

    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new ListTile(
          // leading: new Text(items[index]['courseCode']),
          title: new Text(items[index]['courseName']),
          trailing: new Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursesDetail2(
                          snapshot: items[index],
                        )));
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   final debouncer = Debouncer<String>(Duration(milliseconds: 1000));
  //   debouncer.value = query;
  //   debouncer.values.listen((event) {
  //     print(event);
  //     this.ftCourseSearchBloc.add(FtCourseSearchEvent(event));
  //   });

  //   return BlocBuilder(
  //     bloc: this.ftCourseSearchBloc,
  //     builder: (BuildContext context, FtCourseSearchState state) {
  //       if (state.isLoading) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state.hasError) {
  //         return Container(
  //           child: Text('error'),
  //         );
  //       }
  //       return ListView.builder(
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             title: Text(state.courses[index].courseName),
  //           );
  //         },
  //         itemCount: state.courses.length,
  //       );
  //     },
  //   );
  // }
}
