import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ShortCourseCategory {
  
}

class ShortCourseCategoryPage extends StatelessWidget {
  static const String routeName = "/ptShortCourses";

  const ShortCourseCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = List<String>();
    categoryList.add("BUSINESS & FINANCE");
    categoryList.add("LIFESTYLE & WELLNESS");
    categoryList.add("INFOCOMM & TECHNOLOGY");
    categoryList.add("INDUSTRY CERTIFICATIONS");
    categoryList.add("HUMAN RESOURCE & COMMUNICATION");
    categoryList.add("SECURITY");
    categoryList.add("DESIGN & MEDIA");
    categoryList.add("SKILLSFUTURE FOR DIGITAL WORKPLACE");
    categoryList.add("UNIVERSITY PREPARATORY COURSE");

    return Scaffold(
      appBar: AppBar(
        title: Text("Short Courses"),
      ),
      body: GridView.builder(
          itemCount: categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 375),
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: PtShortCourseItem(
                    title: categoryList[index],
                  ),
                ));
          }),
    );
  }
}

class PtShortCourseItem extends StatelessWidget {
  final String title;
  const PtShortCourseItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                this.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
