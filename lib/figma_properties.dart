import 'package:flutter/material.dart';

class FigmaProperties {
  const FigmaProperties._();

  static const String text = 'text';
  static const String maxLines = 'maxLines';
  static const String overflow = 'overflow';
  static const String softWrap = 'softWrap';

  static const String child = 'child';
  static const String children = 'children';

  static const String layoutInfo = 'layoutInfo';

  static const String width = 'width';
  static const String height = 'height';
  static const String fit = 'fit';

  static const String isTextField = 'isTextField';
  static const String controller = 'controller';
  static const String onChanged = 'onChanged';
  static const String onSubmitted = 'onSubmitted';
  static const String hint = 'hint';

  static const String onTap = 'onTap';

  static const String scrollableContent = 'scrollableContent';
}

enum FigmaFrameFit {
  none,
  contain,
  cover,
  fill,
}

typedef ScrollableItemBuilder = Widget Function(
  BuildContext context,
  int index,
);

class ScrollableContent {
  final int itemCount;
  final ScrollableItemBuilder itemBuilder;

  const ScrollableContent({
    required this.itemCount,
    required this.itemBuilder,
  });
}
