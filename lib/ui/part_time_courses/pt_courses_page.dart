import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../app_bar/custom_app_bar.dart';
import 'pt_skillsfuture/pt_skillsfuture_page.dart';

class PtCoursesPage extends StatefulWidget {
  PtCoursesPage({Key key}) : super(key: key);
  static const String routeName = "/ptCoursesPage";

  @override
  _PartTimeCourseState createState() => _PartTimeCourseState();
}

class _PartTimeCourseState extends State<PtCoursesPage> {
  @override
  Widget build(BuildContext context) {
    List<String> imageUrlList = List<String>();
    imageUrlList.add(
        "assets/images/part_time/banner-1.jpg");
    imageUrlList.add(
        "assets/images/part_time/banner-2.jpg");
    imageUrlList.add(
        "assets/images/part_time/banner-3.jpg");
    imageUrlList.add(
        "assets/images/part_time/banner-4.jpg");
    imageUrlList.add(
        "assets/images/part_time/banner-5.jpg");
    imageUrlList.add(
        "assets/images/part_time/banner-6.jpg");
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          PtCourseSlideshow(imageUrlList: imageUrlList),
          Expanded(child: PtCourseCardList())
        ],
      ),
    );
  }
}

class PtCourseCardList extends StatelessWidget {
  const PtCourseCardList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PtCard> buttonList = List<PtCard>();
    buttonList.add(PtCard(
        title: "SkillsFuture Series",
        buttonText: "SkillsFuture Series",
        subtitle:
            "Stay relevant and upgrade your skills with our diploma and post-diploma courses.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Full Qualification Course",
        buttonText: "Full Qualification Course",
        subtitle:
            "Our short industry relevant training programmes will prepare you for the Future Economy.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "Work-Study Programmes",
        buttonText: "Work-Study Programmes",
        subtitle:
            "For Singaporeans and PR fresh graduates from ITE and Polytechnics. Get a head start in your career and receive on-the-job training while you study.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "Micro-Learning Courses",
        buttonText: "SkillsFuture Series",
        subtitle:
            "Engage in short and activity-based courses that are delivered through a mobile app, your new personal tutor!",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "SAP Skills University",
        buttonText: "SAP Skills University",
        subtitle:
            "Acquire relevant skills for technical SAP roles and attain industry-recognised qualifications.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Corporate Training",
        buttonText: "Corporate Training",
        subtitle:
            "We can help you customise your training so you can meet your staff development needs and position your business for success.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Silver Infocomm Courses",
        buttonText: "Silver Infocomm Courses",
        subtitle:
            "Courses specially designed for seniors to pick up relevant new skills.",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: PtCardList(ptCardList: buttonList),
    );
  }
}

class PtCard {
  String imageUrl;
  String buttonText;
  String title;
  String subtitle;

  PtCard({this.title, this.buttonText, this.imageUrl, this.subtitle});
}

class PtCardList extends StatelessWidget {
  final List<PtCard> ptCardList;

  PtCardList({Key key, this.ptCardList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          itemCount: this.ptCardList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 375),
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: PtCardItem(
                    title: ptCardList[index].title,
                    imageUrl: ptCardList[index].imageUrl,
                    subtitle: ptCardList[index].subtitle,
                  ),
                ));
          }),
      // child: ListView.builder(
      //     itemCount: this.ptCardList.length,
      //     itemBuilder: (BuildContext ctxt, int index) {
      //       return AnimationConfiguration.staggeredList(
      //           duration: const Duration(milliseconds: 375),
      //           position: index,
      //           child: SlideAnimation(
      //             verticalOffset: 50.0,
      //             child: PtCardItem(
      //               title: ptCardList[index].title,
      //               imageUrl: ptCardList[index].imageUrl,
      //             ),
      //           ));
      //     }),
    );
  }
}

class PtCardItem extends StatelessWidget {
  final String title, imageUrl, description, subtitle;
  const PtCardItem(
      {Key key, this.title, this.imageUrl, this.description, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.title == "SkillsFuture Series") {
          Navigator.pushNamed(context, PtSkillsFuture.routeName);
        }
      },
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
                  Text(
                    this.subtitle,
                    style: TextStyle(color: Colors.white70),
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

class PtCourseSlideshow extends StatelessWidget {
  const PtCourseSlideshow({
    Key key,
    @required this.imageUrlList,
  }) : super(key: key);

  final List<String> imageUrlList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Swiper(
        itemCount: imageUrlList.length,
        autoplay: true,
        loop: true,
        duration: 1500,
        pagination: new SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset(
            imageUrlList[index],
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
