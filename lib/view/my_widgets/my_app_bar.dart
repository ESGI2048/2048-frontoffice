import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class MyAppBar extends SliverAppBar {

  MyAppBar({@required String title, @required String image_path, double height: 150.0}) : super(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: MyText(title, color: Color(colorTextEvent), textBold: true, fontSize: 20.0,),
        background: Image.network(image_path, fit: BoxFit.cover,),
      ),
      expandedHeight: height
  );
}