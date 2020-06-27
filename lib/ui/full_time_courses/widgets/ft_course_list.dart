import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sup/quick_sup.dart';
import 'package:tp_app/models/course.dart';
import 'package:tp_app/ui/widgets/loading_widget.dart';

import '../ft_courses_detail_2.dart';
import 'ft_course_card.dart';

class FTCourseList extends StatefulWidget {
  final String school;
  FTCourseList({this.school});

  @override
  _FTCourseListState createState() => _FTCourseListState();
}

class _FTCourseListState extends State<FTCourseList>
    with AutomaticKeepAliveClientMixin {
  Color backgroundColor;
  @override
  void initState() {
    switch (widget.school) {
      case "bus":
        {
          backgroundColor = Colors.yellow;
        }
        break;
      case "eng":
        {
          backgroundColor = Colors.purple;
        }
        break;
      case "des":
        {
          backgroundColor = Colors.blue;
        }
        break;
      case "asc":
        {
          backgroundColor = Colors.green;
        }
        break;
      case "iit":
        {
          backgroundColor = Colors.blue;
        }
        break;
    }
    super.initState();
  }

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
          if (!snapshot.hasData) {
            return LoadingWidget();
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return LoadingWidget();
            case ConnectionState.waiting:
              return LoadingWidget();
            default:
              if (snapshot.hasError)
                return new QuickSup.error(
                  title: 'Nope',
                  subtitle: 'That didn\'t work, son.',
                  onRetry: () {},
                );
              else
                print(snapshot.data.metadata.isFromCache
                    ? "NOT FROM NETWORK"
                    : "FROM NETWORK");
              return AnimationLimiter(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                          colors: [Colors.white, backgroundColor])),
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
                                        builder: (context) => CoursesDetail2(
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
