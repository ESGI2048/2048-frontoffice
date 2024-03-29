import 'package:augarde_2048/view/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/page/home_page.dart';
import 'package:augarde_2048/controller/log_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'StarJedi'
      ),
      home: LogController(),//HomePage(),//LogController(),
      debugShowCheckedModeBanner: false,
    );
  }
} 

