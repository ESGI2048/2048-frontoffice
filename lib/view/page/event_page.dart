import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:augarde_2048/model/event.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          'Event',
          fontSize: 25.0,
          textBold: true,
        ),
        backgroundColor: Color(gridBackground),
      ),
      body: ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            Event event = Event(1, "Title Event", "Une description", "12 rue Nation, 75010 Paris", "http://localhost.png", DateTime.now().millisecondsSinceEpoch);
            return EventTile(event);
          }
      ),
    );
  }
}
