import 'package:flutter/material.dart';

class Event {

  int id;
  String name, place, description;
  Image file_path;
  DateTime date;

  Event(int id, String name, String description, String place, String file_path, int date) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.place = place;
    this.file_path = Image.network(file_path);
    this.date = DateTime.fromMillisecondsSinceEpoch(date * 1000);
  }

  // named constructor
  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        place = json['place'],
        file_path = Image.network(json['file_path']),
        date = DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000);


  // method
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "place": place,
      "file_path": file_path.toString(),
      "date": date.millisecondsSinceEpoch,
    };
  }

  /*String toJsonString() {
    return '{"login": "$login", "password": "$password"}';
  }*/
}