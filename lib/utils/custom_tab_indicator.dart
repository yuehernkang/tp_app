import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const CustomTabIndicator({
    @required this.indicatorHeight,
    @required this.indicatorColor,
  });

  @override
  _CirclePainter createBoxPainter([VoidCallback onChanged]) {
    return new _CirclePainter(this, onChanged);
  }
}

class _CirclePainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CirclePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect;
    rect = Offset(offset.dx,
            (configuration.size.height - decoration.indicatorHeight ?? 3)) &
        Size(configuration.size.width, decoration.indicatorHeight ?? 3);

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor ?? Color(0xff1967d2);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect,
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        paint);
  }
}
