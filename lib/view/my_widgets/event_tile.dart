import 'package:augarde_2048/model/event.dart';
import 'package:augarde_2048/view/page/event_detail_page.dart';
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
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(widget.event))),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          color: white,
          elevation: 5.0,
          child: Container(
            height: 200.0,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.event.file_path),
                //Image.network("https://www.citationbonheur.fr/wp-content/uploads/2018/09/L_influence_du_paysage_sur_le_bonheur.jpg"),
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
            child: MyText(widget.event.name, color: black,
              fontSize: 25.0,
              alignment: TextAlign.start, textBold: true,),
          ),
        ),
      ),
    );
  }
}
