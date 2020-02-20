import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class DropShadow extends BoxShadow {
  DropShadow() : super(blurRadius: 20, offset: Offset(0, 10), color: Colors.black.withOpacity(0.1));
}

class ShadowFrame extends BoxShadow {
  final Color fgColor;
  final double height;

  ShadowFrame({this.fgColor, this.height = 4})
   : super(blurRadius: 0, offset: Offset(0, height), color: TinyColor(fgColor).darken(8).color);
}