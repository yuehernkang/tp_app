import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tp_app/ui/full_time_courses/text_page_indicator.dart';

import 'ft_courses_page.dart';

class FTCoursesPage2 extends StatefulWidget {
  FTCoursesPage2({Key key}) : super(key: key);

  @override
  _FTCoursesPage2State createState() => _FTCoursesPage2State();
}

class _FTCoursesPage2State extends State<FTCoursesPage2> {
  PageController _pageController;

  final scrollDirection = Axis.horizontal;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final _currentPageNotifier = ValueNotifier<int>(0);

  List<String> lvBuilder = List();
  List<Widget> textWidgetList = List();
  List<Widget> tabWidgetList = List();
  List<Widget> lvTextWidget = List();

  int courseNameCurrentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    lvBuilder.add("Business");
    lvBuilder.add("Engineering");
    lvBuilder.add("Design");
    lvBuilder.add("Applied Science");
    tabWidgetList.add(TabWidget(school: "bus"));
    tabWidgetList.add(TabWidget(school: "eng"));
    tabWidgetList.add(TabWidget(school: "des"));
    tabWidgetList.add(TabWidget(school: "asc"));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer<String>(Duration(milliseconds: 200));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: TextPageIndicator(
                items: lvBuilder,
                currentPageNotifier: _currentPageNotifier,
                pageController: _pageController,
                itemPositionsListener: itemPositionsListener,
                itemScrollController: itemScrollController,
              ),
            ),
            Flexible(
              flex: 24,
              child: PageView(
                onPageChanged: (num) {
                  _currentPageNotifier.value = num;
                  debouncer.value = num.toString();
                  debouncer.values.listen((num) {
                    itemScrollController.scrollTo(
                        index: int.parse(num),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic);
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                children: tabWidgetList,
              ),
            )
          ],
        ),
      ),
    );
  }
}
