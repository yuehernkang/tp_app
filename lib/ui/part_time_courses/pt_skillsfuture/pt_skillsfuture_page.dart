import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';
import 'package:flutter/services.dart' show rootBundle;

class PtSkillsFuture extends StatefulWidget {
  static const String routeName = "/ptSkillsFuture";

  PtSkillsFuture({Key key}) : super(key: key);

  @override
  _PtSkillsFutureState createState() => _PtSkillsFutureState();
}

class PtSkillsFutureModule {
  String moduleName, moduleInfo, who, entryRequirement;
  PtSkillsFutureModule(
      {this.moduleName, this.moduleInfo, this.who, this.entryRequirement});

  factory PtSkillsFutureModule.fromJson(Map<String, dynamic> json) {
    return PtSkillsFutureModule(
      moduleName: json['moduleName'] as String,
      moduleInfo: json['moduleInfo'] as String,
      who: json['who'] as String,
      entryRequirement: json['entryRequirement'] as String,
    );
  }
}

class PtSkillsFutureModuleList {
  final List<PtSkillsFutureModule> ptSkillsFutureModule;

  PtSkillsFutureModuleList({this.ptSkillsFutureModule});

  factory PtSkillsFutureModuleList.fromJson(List<dynamic> parsedJson) {
    List<PtSkillsFutureModule> ptSkillsFutureModule =
        new List<PtSkillsFutureModule>();
    ptSkillsFutureModule =
        parsedJson.map((i) => PtSkillsFutureModule.fromJson(i)).toList();

    return new PtSkillsFutureModuleList(
        ptSkillsFutureModule: ptSkillsFutureModule);
  }
}

class PtSkillsFutureCourse {
  String imageUrl, courseName, coverImageUrl, localImage;
  PtSkillsFutureModuleList basic = new PtSkillsFutureModuleList();
  PtSkillsFutureCourse(
      {this.courseName,
      this.imageUrl,
      this.coverImageUrl,
      this.localImage,
      this.basic});

  factory PtSkillsFutureCourse.fromJson(Map<String, dynamic> json) {
    return PtSkillsFutureCourse(
        courseName: json['courseName'] as String,
        imageUrl: json['imageUrl'] as String,
        localImage: json['localImage'] as String,
        coverImageUrl: json['coverImageUrl'] as String,
        basic: json['basic'] as PtSkillsFutureModuleList);
  }
}

class _PtSkillsFutureState extends State<PtSkillsFuture> {
  @override
  Widget build(BuildContext context) {
    Future _loadCourseAsset() async {
      return await rootBundle.loadString("assets/pt-skillsfuture.json");
    }

    Future loadCourse() async {
      String jsonString = await _loadCourseAsset();
      final jsonResponse = json.decode(jsonString);
      return jsonResponse;
    }

    final courseWidget = FutureBuilder(
        future: loadCourse(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return PtSkillsFutureCourseList(courses: snapshot.data);
          }
        });
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Image.asset(
              'assets/images/part_time/skillsfuture/SC-Banner---MLC-Giveaway.jpg'),
          Card(
            color: Theme.of(context).cardColor,
            elevation: 8.0,
            child: ListTile(
              title: Center(
                child: Text("SkillsFuture Series", style: Theme.of(context).primaryTextTheme.subtitle1),
              ),
              subtitle: Column(
                children: <Widget>[
                  Text(
                      "The SkillsFuture Series is a curated list of short, industry-relevant training programmes that focus on emerging skills. Complete a SkillsFuture Series course today and you will get a FREE online Micro-Learning Course that you can learn using your mobile devices.",
                      style: Theme.of(context).primaryTextTheme.subtitle1),
                  MaterialButton(
                    child: Text("More Info", style: Theme.of(context).primaryTextTheme.subtitle1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PtSkillsFutureMoreInfo()),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          courseWidget
        ],
      ),
    );
  }
}

class PtSkillsFutureCourseList extends StatelessWidget {
  final List<dynamic> courses;
  const PtSkillsFutureCourseList({Key key, this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: this.courses.length,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          // ),
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 375),
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PtSkillsFutureCourseDetails(
                                ptSkillsFutureModuleList:
                                    PtSkillsFutureModuleList.fromJson(
                                        courses[index]['basic']))),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 40.0,
                          child: Image.asset(this.courses[index]['localImage']),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                this.courses[index]['courseName'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}

class PtSkillsFutureMoreInfo extends StatelessWidget {
  const PtSkillsFutureMoreInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Text("Who is it for?", style: Theme.of(context).textTheme.headline3),
          Container(
            margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(children: [
                  Center(child: Text('LEVEL')),
                  Center(child: Text('LEVEL DESCRIPTOR')),
                ]),
                TableRow(children: [
                  Center(child: Text('Basic')),
                  Text(
                      'The course is designed for learners who have limited or no prior knowledge in the subject area. The course covers basic knowledge and application.'),
                ]),
                TableRow(children: [
                  Center(child: Text('Intermediate')),
                  Text(
                      'The course is designed for learners who have some working knowledge of the subject area. The course covers knowledge and application at a more complex level.'),
                ]),
                TableRow(children: [
                  Center(child: Text('Advanced')),
                  Text(
                      'The course is designed for experienced practitioners who wish to deepen their skills in the specialised area. The course covers complex and specialised topics.'),
                ])
              ],
            ),
          ),
          Text("Funding", style: Theme.of(context).textTheme.headline3),
          Container(
              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                  "70% course fee support for Singaporeans and Singapore Permanent Residents. \n\nEnhanced funding schemes available (e.g. SkillsFuture Mid-Career Enhanced Subsidy (MCES), Enhanced Training Support for SMEs (ETSS)).",
                  style: Theme.of(context).textTheme.subtitle1)),
        ],
      ),
    );
  }
}

class PtSkillsFutureCourseDetails extends StatelessWidget {
  final PtSkillsFutureModuleList ptSkillsFutureModuleList;
  const PtSkillsFutureCourseDetails({Key key, this.ptSkillsFutureModuleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Text(
            "Basic Modules",
            style: Theme.of(context).textTheme.headline3,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: ptSkillsFutureModuleList.ptSkillsFutureModule.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpandablePanel(
                      header: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                            ptSkillsFutureModuleList
                                .ptSkillsFutureModule[index].moduleName,
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      expanded: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(ptSkillsFutureModuleList
                            .ptSkillsFutureModule[index].moduleInfo),
                      ),
                      collapsed: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          ptSkillsFutureModuleList
                              .ptSkillsFutureModule[index].moduleInfo,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
