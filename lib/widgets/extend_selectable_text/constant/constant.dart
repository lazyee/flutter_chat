import 'package:flutter/cupertino.dart';

const double kDefaultSelectionHandleOverlap = 1.5;
// Extracted from https://developer.apple.com/design/resources/.
const double kDefaultSelectionHandleRadius = 6;

// Minimal padding from all edges of the selection toolbar to all edges of the
// screen.
const double kDefaultToolbarScreenPadding = 8.0;
// Minimal padding from tip of the selection toolbar arrow to horizontal edges of the
// screen. Eyeballed value.
const double kDefaultArrowScreenPadding = 26.0;

// Vertical distance between the tip of the arrow and the line of text the arrow
// is pointing to. The value used here is eyeballed.
const double kDefaultToolbarContentDistance = 8.0;
// Values derived from https://developer.apple.com/design/resources/.
// 92% Opacity ~= 0xEB

// Values extracted from https://developer.apple.com/design/resources/.
// The height of the toolbar, including the arrow.
const double kDefaultToolbarHeight = 43.0;
const Size kDefaultToolbarArrowSize = Size(14.0, 7.0);
const Radius kDefaultToolbarBorderRadius = Radius.circular(8.0);

//操作栏的背景颜色
const Color kDefaultToolbarBackgroundColor = Color(0xEB202020);
// const Color kDefaultToolbarBackgroundColor = Colors.red;
const Color kDefaultToolbarDividerColor = Color(0xFF808080);

const EdgeInsets kDefaultToolbarButtonPadding =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0);

const TextStyle kDefaultToolbarButtonFontStyle = TextStyle(
  inherit: false,
  fontSize: 14.0,
  letterSpacing: -0.15,
  fontWeight: FontWeight.w400,
  color: CupertinoColors.white,
);

const TextStyle kDefaultToolbarButtonDisabledFontStyle = TextStyle(
  inherit: false,
  fontSize: 14.0,
  letterSpacing: -0.15,
  fontWeight: FontWeight.w400,
  color: CupertinoColors.inactiveGray,
);
