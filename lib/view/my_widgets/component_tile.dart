import 'package:augarde_2048/model/component.dart';
import 'package:augarde_2048/view/page/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class ComponentTile extends StatelessWidget {
  Component component;

  ComponentTile(this.component);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          color: white,
          elevation: 5.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Image.network(component.file_path),
              ),
              MyText(component.type, textBold: true, fontSize: 20.0, color: black,),
              PaddingWith(widget: MyText("Valeur: ${component.value}", color: black,), right: 20.0,)
            ],
          )
        ),
    );
  }
}
