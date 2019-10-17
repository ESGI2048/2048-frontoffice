import 'package:augarde_2048/model/event.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class EventTile extends StatefulWidget {
  Event event;

  EventTile(this.event);

  @override
  State<StatefulWidget> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(2.5),
      child: Card(
        color: white,
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyText(widget.event.name, color: Colors.black,),
            ],
          ),
        ),
      ),
    );
  }
}
