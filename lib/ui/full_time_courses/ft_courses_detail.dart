import 'package:expandable/expandable.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tp_app/models/course.dart';

class CoursesDetail extends StatefulWidget {
  final Course course;
  CoursesDetail({Key key, this.course}) : super(key: key);

  @override
  _CoursesDetailState createState() => _CoursesDetailState();
}

class _CoursesDetailState extends State<CoursesDetail> {
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
              title: Text(title),
              subtitle: Text(details),
            )
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> yearList = List<Widget>(3);
    yearList[0] = yearCard("Year 1", widget.course.year1);
    yearList[1] = yearCard("Year 2", widget.course.year2);
    yearList[2] = yearCard("Year 3", widget.course.year3);

    return Scaffold(
      appBar: AppBar(title: Text(widget.course.courseName)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.course.courseCode,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(widget.course.image),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text(
                    "Course Details",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  collapsed: Text(
                    "",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(widget.course.courseDetails),
                ),
              ),
            ),
            Container(
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
                            return yearList[index];
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
            ),
          ],
        ),
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
