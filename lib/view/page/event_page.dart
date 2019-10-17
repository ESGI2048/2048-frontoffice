import 'package:augarde_2048/controller/bdd_helper.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:augarde_2048/model/event.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  Future<List<Event>> eventList;


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
      body: FutureBuilder<List<Event>> (
        future: eventList = BddHelper().getEvents(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<Event> lst = snapshot.data;
            return ListView.builder(
                itemCount: lst.length,
                itemBuilder: (BuildContext context, int index) {
                  Event event = lst[index];
                  //Event event = Event(1, "Title Event", "Une description", "12 rue Nation, 75010 Paris", "http://localhost.png", DateTime.now().toString());
                  return EventTile(event);
                }
            );
          } else {
            return Text("Aucun événements pour le moment");
          }
        }
      )
    );
  }
}

/*

ListView.builder(
          itemCount: eventList,
          itemBuilder: (BuildContext context, int index) {
            Event event = Event(1, "Title Event", "Une description", "12 rue Nation, 75010 Paris", "http://localhost.png", DateTime.now().toString());
            return EventTile(event);
          }
      ),
 */
