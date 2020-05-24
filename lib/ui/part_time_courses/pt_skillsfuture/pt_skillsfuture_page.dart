import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tp_app/ui/widgets/loading_widget.dart';

import '../../app_bar/custom_app_bar.dart';
import 'models/pt_skillsfuture_module_list.dart';
import 'pt_skillsfuture_module_page.dart';
import 'pt_skillsfuture_more_info_page.dart';

class PtSkillsFuture extends StatefulWidget {
  static const String routeName = "/ptSkillsFuture";

  PtSkillsFuture({Key key}) : super(key: key);

  @override
  _PtSkillsFutureState createState() => _PtSkillsFutureState();
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
            return new LoadingWidget();
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
            color: Colors.red,
            elevation: 8.0,
            child: ListTile(
              title: Center(
                child: Text("SkillsFuture Series", style: Theme.of(context).primaryTextTheme.subtitle),
              ),
              subtitle: Column(
                children: <Widget>[
                  Text(
                      "The SkillsFuture Series is a curated list of short, industry-relevant training programmes that focus on emerging skills. Complete a SkillsFuture Series course today and you will get a FREE online Micro-Learning Course that you can learn using your mobile devices.",
                      style: Theme.of(context).primaryTextTheme.subtitle),
                  MaterialButton(
                    child: Text("More Info", style: Theme.of(context).primaryTextTheme.subtitle),
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
                            builder: (context) => PtSkillsFutureModulesPage(
                                ptSkillsFutureModuleList:
                                    PtSkillsFutureModuleList.fromJson(
                                        courses[index]['basic']))),
                      );
                    },
                    child: Card(
                      // color: Theme.of(context).cardColor,
                      color: Colors.white,
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
                                style: TextStyle(
                                  color: Colors.red
                                ),
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



