import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'short_course_list.dart';

class ShortCourseCategory {
  final displayText, imageUrl;

  ShortCourseCategory({this.displayText, this.imageUrl});
}

class ShortCourseCategoryPage extends StatelessWidget {
  static const String routeName = "/ptShortCourseCategory";

  const ShortCourseCategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShortCourseCategory> categoryList = List<ShortCourseCategory>();
    categoryList.add(ShortCourseCategory(
        displayText: "BUSINESS & FINANCE",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Business-&-Finance.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "LIFESTYLE & WELLNESS",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Lifestyle-&-Wellness.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "INFOCOMM & TECHNOLOGY",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Infocomm-&-Technology.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "INDUSTRY CERTIFICATIONS",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Industry-Certifications.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "HUMAN RESOURCE & COMMUNICATION",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Human-Resource-&-Communication.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "SECURITY",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Security.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "DESIGN & MEDIA",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-Design-&-Media.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "SKILLSFUTURE FOR DIGITAL WORKPLACE",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-SkillsFuture-for-Digital-Workplace.jpg"));
    categoryList.add(ShortCourseCategory(
        displayText: "UNIVERSITY PREPARATORY COURSE",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/images/Centres/tsa/short_courses/SC-University-Preparatory-Course.jpg"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Short Courses"),
      ),
      body: GridView.builder(
          itemCount: categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.5),
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 375),
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: PtShortCourseItem(
                    item: categoryList[index],
                  ),
                ));
          }),
    );
  }
}

class PtShortCourseItem extends StatelessWidget {
  final ShortCourseCategory item;
  const PtShortCourseItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ShortCourseListPage.routeName,
            arguments: item.displayText);
      },
      child: Card(
        borderOnForeground: true,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).accentColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: item.displayText,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Colors.black54
,
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          item.displayText,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    )
                  ],
                )
                // AutoSizeText(
                //   item.displayText ?? 'Course Name',
                //   maxLines: 2,
                //   minFontSize: 16,
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ],
        ),
        // child: Stack(
        //   children: <Widget>[
        //     CachedNetworkImage(
        //       imageUrl: item.imageUrl,
        //       fit: BoxFit.fill,
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Container(
        //           color: Colors.black.withOpacity(0.5),
        //           child: ListTile(
        //             title: Text(
        //               item.displayText,
        //               style: TextStyle(
        //                   color: Colors.white, fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
