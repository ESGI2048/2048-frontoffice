import 'package:flutter/material.dart';

class MyText extends Text {

  MyText(data, {
    TextAlign alignment: TextAlign.center,
    double fontSize: 17.0,
    FontStyle style: FontStyle.normal,
    Color color: Colors.white,
    bool textBold: false,
  }): super(
      data,
      textAlign: alignment,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: style,
        color: color,
        fontWeight: (textBold) ? FontWeight.bold : FontWeight.normal,
      )
  );



}