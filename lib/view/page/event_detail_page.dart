import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:augarde_2048/model/event.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class EventDetail extends StatelessWidget {
  Event event;

  EventDetail(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext build, bool scrolled) {
            return [MyAppBar(title: event.name, image: logoImage)];
          },
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                PaddingWith(
                  widget: MyText(
                    event.date.toString(),
                    color: black,
                    fontSize: 20.0,
                  ),
                  top: 60.0,
                ),
                PaddingWith(
                  widget: MyText(
                    event.description,
                    color: black,
                  ),
                  top: 15.0,
                ),
                PaddingWith(
                  widget: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                    child: showMap(),
                  ),
                  top: 20.0,
                ),
                // showMap(),
              ],
            ),
          ))),
    );
  }

  Widget showMap() {
    return FlutterMap(
        options:
            new MapOptions(center: new LatLng(35.22, -101.83), minZoom: 5.0),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/wemouv/ck1uun8e208dq1cldxa4ubtd2.html?fresh=true&title=true&access_token=pk.eyJ1Ijoid2Vtb3V2IiwiYSI6ImNqcGgxN21tZjBwYWgzcWxxZ242NHd5NjkifQ.dbudKtF6QmygxeD1osCvbA#9.0/37.780000/-122.424100/0",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1Ijoid2Vtb3V2IiwiYSI6ImNqcGgxN21tZjBwYWgzcWxxZ242NHd5NjkifQ.dbudKtF6QmygxeD1osCvbA',
                'id': 'mapbox.mapbox-streets-v7'
              }),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(35.215, -101.825),
                builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.blue,
                        iconSize: 45.0,
                        onPressed: () {
                          print('Marker tapped');
                        },
                      ),
                    ))
          ])
        ]);
  }
}
