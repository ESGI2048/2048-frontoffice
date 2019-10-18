import 'dart:convert';
import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:augarde_2048/model/component.dart';
import 'package:augarde_2048/model/event.dart';
import 'package:augarde_2048/model/user.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:http/http.dart';
import 'dart:async';

class BddHelper {

  final Map<String, String> headers = {"Content-type": "application/json"};

  // access localhost from the emulator/simulator
  String hostname() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:8888';
    else
      return 'http://localhost:8888';
  }

  // GET AUTHENTICATION FOR USER LOGIN
  Future<bool> getUserLogin(String login, String password) async {
    String json = '{"login": "$login", "password": "$password"}';
    Response response = await post('${hostname()}/login', headers: headers, body: json);
    int statusCode = response.statusCode;
    String jsonString = response.body;
    print('Status: $statusCode, $jsonString');
    if (statusCode == 200) {
      me = User(login, password);
      return true;
    }
    return false;
  }


  // POST AUTHENTIFICATION USER SIGN UP
  Future<bool> postUserSignUp(String login, String password) async {
    // set up POST request arguments
    String json = '{"firstName": "test", "lastName": "test", "email": "test@example.fr", "login": "$login", "score": 0, "phone": "07.00.00.00.00", "password": "$password"}';
    // make POST request
    Response response = await post('${hostname()}/signup', headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
    if (statusCode == 200) {
      me = User(login, password);
      return true;
    }
    return false;
  }

  // GET ALL EVENTS
  Future<List<Event>> getEvents() async {
    String url = '${hostname()}/event';
    Response response = await get(url);
    int statusCode = response.statusCode;
    String jsonString = response.body;
    var res = jsonDecode(jsonString);
    print('Status: $statusCode, $jsonString, $res');
    if (statusCode == 200) {
      return createListEvent(res);
    }
    return null;
  }

  List<Event> createListEvent(List<dynamic> json) {
    List<Event> list = new List();
    json.forEach((elem) {
      Event event = Event.fromJson(elem);
      event.setFilePath('${hostname()}/resource/${event.file_path}');
      list.add(event);
    });

    return list;
  }



  // GET ALL COMPONENTS
  Future<List<Component>> getComponents() async {
    String url = '${hostname()}/component';
    Response response = await get(url);
    int statusCode = response.statusCode;

    String jsonString = response.body;
    var res = jsonDecode(jsonString);
    print('Status: $statusCode, $jsonString, $res');
    if (statusCode == 200) {
      return createListComponent(res);
    }
    return null;
  }

  List<Component> createListComponent(List<dynamic> json) {
    List<Component> list = new List();
    json.forEach((elem) {
      Component component = Component.fromJson(elem);
      component.setFilePath('${hostname()}/resource/${component.file_path}');
      list.add(component);
    });
    return list;
  }


/* EXAMPLE

  // GET all
  makeGetAllRequest() async {
    // get everything
    Response response = await get(hostname());
    // examples of info available in response
    int statusCode = response.statusCode;
    String jsonString = response.body;
    print('Status: $statusCode, $jsonString');
  }

  // GET one
  makeGetOneRequest() async {
    // only get a single item at index 0
    //String url2= 'http://10.0.2.2:8888/authentication/rutrum.magna@velitQuisquevarius.org';
    String idToGet = 'rutrum.magna@velitQuisquevarius.org';
    String url = '${hostname()}/authentication/$idToGet';
    Response response = await get(url);
    int statusCode = response.statusCode;
    String jsonString = response.body;
    print('Status: $statusCode, $jsonString');
  }

  // POST
  makePostRequest() async {
    // set up POST request arguments
    String json = '{"fruit": "pear", "color": "green"}';
    // make POST request
    Response response = await post(hostname(), headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
  }

  // PUT
  makePutRequest() async {
    // set up PUT request arguments
    int idToReplace = 0;
    String url = '${hostname()}/$idToReplace';
    String json = '{"fruit": "watermellon", "color": "red and green"}';
    // make PUT request
    Response response = await put(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
  }

  // PATCH
  makePatchRequest() async {
    // set up PATCH request arguments
    int idToUpdate = 0;
    String url = '${hostname()}/$idToUpdate';
    String json = '{"color": "green"}';
    // make PATCH request
    Response response = await patch(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
  }

  // DELETE
  void makeDeleteRequest() async {
    // set up DELETE request argument
    int idToDelete = 0;
    String url = '${hostname()}/$idToDelete';
    // make DELETE request
    Response response = await delete(url);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
  }

 */
}