import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tp_app/ui/app_bar/custom_app_bar.dart';

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
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-1.jpg");
    imageUrlList.add(
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-2.jpg");
    imageUrlList.add(
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-3.jpg");
    imageUrlList.add(
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-4.jpg");
    imageUrlList.add(
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-5.jpg");
    imageUrlList.add(
        "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/banner-6.jpg");
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PtCourseSlideshow(imageUrlList: imageUrlList),
            PtCourseCardList()
          ],
        ),
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
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Full Qualification Course",
        buttonText: "Full Qualification Course",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "Work-Study Programmes",
        buttonText: "Work-Study Programmes",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "Micro-Learning Courses",
        buttonText: "SkillsFuture Series",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));

    buttonList.add(PtCard(
        title: "SAP Skills University",
        buttonText: "SAP Skills University",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Corporate Training",
        buttonText: "Corporate Training",
        imageUrl:
            "https://www.tp.edu.sg/staticfiles/TP/microsites/cet/2020/images/courses-sfs.png"));
    buttonList.add(PtCard(
        title: "Silver Infocomm Courses",
        buttonText: "Silver Infocomm Courses",
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

  PtCard({this.title, this.buttonText, this.imageUrl});
}

class PtCardList extends StatelessWidget {
  final List<PtCard> ptCardList;

  PtCardList({Key key, this.ptCardList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: this.ptCardList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 375),
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: PtCardItem(
                    title: ptCardList[index].title,
                    imageUrl: ptCardList[index].imageUrl,
                  ),
                ));
          }),
    );
  }
}

class PtCardItem extends StatelessWidget {
  final String title, imageUrl, description;
  const PtCardItem({Key key, this.title, this.imageUrl, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: ListTile(
        title: Text(
          this.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Engage in short and activity-based courses that are delivered through a mobile app, your new personal tutor!"),
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
          return new Image.network(
            imageUrlList[index],
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
