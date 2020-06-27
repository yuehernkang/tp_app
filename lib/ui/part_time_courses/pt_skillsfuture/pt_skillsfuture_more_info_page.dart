import 'package:flutter/material.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';

class PtSkillsFutureMoreInfo extends StatelessWidget {
  const PtSkillsFutureMoreInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Text("Who is it for?", style: Theme.of(context).textTheme.headline),
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
          Text("Funding", style: Theme.of(context).textTheme.headline),
          Container(
              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                  "70% course fee support for Singaporeans and Singapore Permanent Residents. \n\nEnhanced funding schemes available (e.g. SkillsFuture Mid-Career Enhanced Subsidy (MCES), Enhanced Training Support for SMEs (ETSS)).",
                  style: Theme.of(context).textTheme.subtitle)),
        ],
      ),
    );
  }
}

