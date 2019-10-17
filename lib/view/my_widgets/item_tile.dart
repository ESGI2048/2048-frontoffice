import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class ItemTile extends StatefulWidget {
  String number;
  double width, height;
  int color;
  double size;
  String imageFilepath;


  ItemTile(this.number, this.width, this.height, this.color, this.size, this.imageFilepath);

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
      decoration: new BoxDecoration(

          color: Color(widget.color),
          image: DecorationImage(
            image: widget.number == '' ? new AssetImage(
                'assets/empty.png') : new AssetImage(
                'assets/cadran_2.png'),
            fit: BoxFit.fill,
          ),

          borderRadius: BorderRadius.all(Radius.circular(10.0))),

    );
  }
}


/*
decoration: new BoxDecoration(
image: DecorationImage(
image: new AssetImage(
'assets/alucard.jpg'),
fit: BoxFit.fill,
),
borderRadius:
BorderRadius.circular(80.0),
),
 */