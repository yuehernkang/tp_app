import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../utils/custom_tab_indicator.dart';

class ShortCourseDetail extends StatefulWidget {
  static const String routeName = "/shourtCourseDetail";
  final DocumentSnapshot snapshot;

  const ShortCourseDetail({Key key, this.snapshot}) : super(key: key);

  @override
  _ShortCourseDetailState createState() => _ShortCourseDetailState();
}

class _ShortCourseDetailState extends State<ShortCourseDetail> {
  List<Tab> tabs = List<Tab>();
  List<Widget> tabContent = List<Widget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance
          .collection('pt_short_courses')
          .document(widget.snapshot.documentID)
          .collection('tabsData')
          .document('tabsData')
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasData) {
              List tabListArray = snapshot.data['tabs'];
              tabListArray.forEach((element) {
                print(element);
                int tabId = tabListArray.indexOf(element) + 1;
                tabContent.add(SingleChildScrollView(
                    child:
                        HtmlWidget(snapshot.data['tab' + tabId.toString()])));
                tabs.add(Tab(text: element));
              });
            }
            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  title: Text(widget.snapshot.data['course_name'], style: TextStyle(color: Colors.black),),
                  centerTitle: true,
                  backgroundColor: Theme.of(context).cardColor,
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Color(0xff5f6368),
                    indicator: CustomTabIndicator(
                      indicatorHeight: 3,
                      indicatorColor: Theme.of(context).accentColor,
                    ),
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  children: tabContent,
                ),
              ),
            );
        }
      },
    );
  }
}
