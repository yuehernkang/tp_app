import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:tp_app/ui/part_time_courses/pt_skillsfuture/models/pt_skillsfuture_module_list.dart';

class FtCoursesModulePage extends StatelessWidget {
  final DocumentSnapshot snapshot;
  const FtCoursesModulePage({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Course Modules"),
        ),
        body: StreamBuilder(
            stream: snapshot.reference
                .collection('modules')
                .orderBy('modulePosition')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final List<DocumentSnapshot> ftFundamentalModules = snapshot
                  .data.documents
                  .where((DocumentSnapshot documentSnapshot) =>
                      documentSnapshot['moduleGroup'] == 'fundamental_modules')
                  .toList();
              final List<DocumentSnapshot> ftCoreModules = snapshot
                  .data.documents
                  .where((DocumentSnapshot documentSnapshot) =>
                      documentSnapshot['moduleGroup'] == 'core_modules')
                  .toList();
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              return new CustomScrollView(
                slivers: [
                  _StickyHeaderList(
                      title: "Fundamental Modules",
                      ptSkillsFutureModuleList: ftFundamentalModules),
                  _StickyHeaderList(
                      title: "Core Modules",
                      ptSkillsFutureModuleList: ftCoreModules),
                ],
              );
            }));
  }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({Key key, this.title, this.ptSkillsFutureModuleList})
      : super(key: key);

  final String title;
  final List<dynamic> ptSkillsFutureModuleList;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Header(
        title: this.title,
        color: Theme.of(context).accentColor,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            title: Text(ptSkillsFutureModuleList[i]['moduleName']),
            subtitle: Text(ptSkillsFutureModuleList[i]['moduleCode']),
          ),
          childCount: ptSkillsFutureModuleList.length,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.index,
    this.title,
    this.color = Colors.redAccent,
  }) : super(key: key);

  final String title;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title ?? 'Header #$index',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
