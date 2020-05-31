import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TextPageIndicator extends StatefulWidget {
  static const double _defaultSize = 8.0;
  static const double _defaultSelectedSize = 8.0;
  static const double _defaultSpacing = 8.0;
  static const Color _defaultDotColor = const Color(0x509E9E9E);
  static const Color _defaultSelectedDotColor = Colors.grey;

  /// The current page index ValueNotifier
  final ValueNotifier<int> currentPageNotifier;

  /// The number of items managed by the PageController
  // final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  ///The dot color
  final Color dotColor;

  ///The selected dot color
  final Color selectedDotColor;

  ///The normal dot size
  final double size;

  ///The selected dot size
  final double selectedSize;

  ///The space between dots
  final double dotSpacing;
  final VoidCallback onPressedCallback;
  final List<String> items;

  final PageController pageController;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  TextPageIndicator(
      {Key key,
      @required this.currentPageNotifier,
      // @required this.itemCount,
      this.onPageSelected,
      this.size = _defaultSize,
      this.dotSpacing = _defaultSpacing,
      Color dotColor,
      Color selectedDotColor,
      this.selectedSize = _defaultSelectedSize,
      this.onPressedCallback,
      @required this.items,
      @required this.pageController,
      this.itemScrollController,
      this.itemPositionsListener})
      : this.dotColor = dotColor ??
            ((selectedDotColor?.withAlpha(150)) ?? _defaultDotColor),
        this.selectedDotColor = selectedDotColor ?? _defaultSelectedDotColor,
        super(key: key);

  @override
  TextPageIndicatorState createState() {
    return new TextPageIndicatorState();
  }
}

class TextPageIndicatorState extends State<TextPageIndicator> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    _readCurrentPageIndex();
    widget.currentPageNotifier.addListener(_handlePageIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier.removeListener(_handlePageIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        padding: const EdgeInsets.only(right: 160),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemScrollController: widget.itemScrollController,
        itemPositionsListener: widget.itemPositionsListener,
        itemBuilder: (BuildContext ctxt, int index) {
          return Row(
            children: [
              TextWidget(
                school: widget.items[index],
                currentPageNotifier: widget.currentPageNotifier,
                onPressedCallback: () {
                  // widget.itemScrollController.scrollTo(
                  //     index: index,
                  //     duration: Duration(milliseconds: 400),
                  //     curve: Curves.easeInOutCubic);

                  widget.pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear);
                },
              ),
              SizedBox(
                width: 20,
              )
            ],
          );
        });
  }

  bool isSelected(int dotIndex) => _currentPageIndex == dotIndex;

  _handlePageIndex() {
    setState(_readCurrentPageIndex);
  }

  _readCurrentPageIndex() {
    _currentPageIndex = widget.currentPageNotifier.value;
  }
}

class TextWidget extends StatefulWidget {
  final String school;
  final PageController pageController;
  final VoidCallback onPressedCallback;
  final ValueNotifier<int> currentPageNotifier;

  TextWidget(
      {Key key,
      this.school,
      this.pageController,
      this.onPressedCallback,
      this.currentPageNotifier})
      : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    _readCurrentPageIndex();
    widget.currentPageNotifier.addListener(_handlePageIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.currentPageNotifier.removeListener(_handlePageIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressedCallback(),
      child: Text(this.widget.school,
          style: TextStyle(
              color: isSelected(_currentPageIndex) ? Colors.black : Colors.grey,
              fontSize: 32)),
    );
  }

  bool isSelected(int dotIndex) => _currentPageIndex == dotIndex;

  _handlePageIndex() {
    setState(_readCurrentPageIndex);
  }

  _readCurrentPageIndex() {
    _currentPageIndex = widget.currentPageNotifier.value;
  }
}
