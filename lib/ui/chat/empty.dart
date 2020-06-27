
import 'package:flutter/material.dart';

class Empty extends Widget {
  @override
  Element createElement() => EmptyElement(this);
}

class EmptyElement extends Element {
  EmptyElement(Widget widget) : super(widget);

  @override
  void forgetChild(Element child) {}

  @override
  void performRebuild() {}

  @override
  // TODO: implement debugDoingBuild
  bool get debugDoingBuild => throw UnimplementedError();
}
