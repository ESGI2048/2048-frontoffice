import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class ItemTile extends StatefulWidget {
  String number;
  double width, height;
  int color;
  double size;

  ItemTile(this.number, this.width, this.height, this.color, this.size);

  @override
  State<StatefulWidget> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: MyText(
          widget.number,
          color: Color(fontColorTwoFour),
          fontSize: widget.size,
          textBold: true,
        ),
      ),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: Color(widget.color),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
