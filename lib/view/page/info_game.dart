import 'package:augarde_2048/model/component.dart';
import 'package:augarde_2048/view/my_widgets/component_tile.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';

class InfoGame extends StatelessWidget {
  Future<List<Component>> componentList;

  InfoGame(this.componentList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: MyText(
            'Info',
            fontSize: 25.0,
            textBold: true,
          ),
          backgroundColor: Color(gridBackground),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PaddingWith(widget: MyText(
                    "Règles du 2048",
                    color: black,
                    fontSize: 20.0,
                    textBold: true,
                  ),
                  top: 20.0,),
                  PaddingWith(widget: MyText(
                    "Le but du jeu est de faire glisser des tuiles sur une grille, pour combiner les tuiles de mêmes valeurs et créer ainsi une tuile portant le nombre 64.\nA la fin de la partie, vous obtiendrez un code de réduction d'une valeur de -15% sur l'achat d'une montre.",
                    alignment: TextAlign.start,
                    color: black,
                  ),
                  right: 20.0,
                  top: 20.0,
                  left: 20.0,
                  bottom: 20.0,),

                  MyText(
                    "Valeur des Card",
                    color: black,
                    fontSize: 20.0,
                    textBold: true,
                  ),
                  PaddingWith(widget: FutureBuilder<List<Component>>(
                    future: componentList,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        List<Component> lst = snapshot.data;
                        lst.sort((elem1, elem2) { return elem1.value - elem2.value; });
                        return Container(
                          height: 500.0,
                          child: ListView.builder(
                              itemCount: lst.length,
                              itemBuilder: (BuildContext context, int index) {
                                Component component = lst[index];
                                return ComponentTile(component);
                              }),
                        );
                      } else {
                        return Text("");
                      }
                    },
                  ),
                    top: 20.0,
                    bottom: 20.0,
                  ),


                ],
              ),
          )
        ));
  }
}
