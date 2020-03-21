import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';

class ScholarshipPage extends StatefulWidget {
  static const String routeName = "/scholarshipPage";

  ScholarshipPage({Key key}) : super(key: key);

  @override
  _ScholarshipPageState createState() => _ScholarshipPageState();
}

class _ScholarshipPageState extends State<ScholarshipPage> {
  @override
  Widget build(BuildContext context) {
    List<String> scholarshipList = List<String>();
    scholarshipList.add("Temasek Polytechnic Scholarship");
    scholarshipList.add("Temasek Polytechnic Engineering Scholarship");
    scholarshipList.add("Industry-sponsored Scholarships");
    scholarshipList.add(
        "Temasek Polytechnic - Polytechnic Foundation Programme Scholarship");
    scholarshipList.add("Co-Curricular Activities Scholarships");
    scholarshipList.add("Co-Curricular Activities Awards");

    return Scaffold(
      appBar: CustomAppBar(),
      body: AnimationLimiter(
        child: Container(
          child: ListView.builder(
              itemCount: scholarshipList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 375),
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: cardInfo(scholarshipList[index]),
                    ));
              }),
        ),
      ),
    );
  }

  Widget cardInfo(String title) {
    return Card(
      child: ListTile(
        title: Text(title),
      ),
    );
  }
}
