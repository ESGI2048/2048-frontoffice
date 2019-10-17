import 'dart:io';

import 'package:flutter/material.dart';

class Event {

  int id;
  String name, place, description;
  String file_path;
  String date;

  Event(int id, String name, String description, String place, String file_path, String date) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.place = place;
    this.file_path = file_path;
    this.date = date;
  }

  // named constructor
  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        place = json['place'],
        file_path = json['file_path'],
        date = json['date'];


  // method
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "place": place,
      "file_path": file_path,
      "date": date,
    };
  }

  setFilePath(String filePath) {
    this.file_path = filePath;
  }
  /*String toJsonString() {
    return '{"login": "$login", "password": "$password"}';
  }*/
}