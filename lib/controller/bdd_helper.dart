import 'dart:convert';
import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:augarde_2048/model/event.dart';
import 'package:augarde_2048/model/user.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:flutter/cupertino.dart';
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
  Future<bool> getUserLogin(String login) async {
    String url = '${hostname()}/authentication/$login';
    Response response = await get(url);
    int statusCode = response.statusCode;
    String jsonString = response.body;
    print('Status: $statusCode, $jsonString');
    if (statusCode == 200) {
      return true;
    }
    return false;
  }


  // POST AUTHENTIFICATION USER SIGN UP
  Future<bool> postUserSignUp(String login, String password) async {
    // set up POST request arguments
    String json = '{"login": "$login", "password": "$password"}';
    print(json);
    // make POST request
    Response response = await post('${hostname()}/user', headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print('Status: $statusCode, $body');
    if (statusCode == 200) {
      me = User(login, password);
      return true;
    }
    return false;
  }


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
    json.forEach((elem) async {
      Event event = Event.fromJson(elem);
      event.setFilePath('${hostname()}/resource/${event.file_path}');
      list.add(event);
    });

    return list;
  }


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



/*
  //AUTH
  final auth_instance = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String mail, String pwd) async {
    final FirebaseUser user = await auth_instance.signInWithEmailAndPassword(email: mail, password: pwd);
    return user;
  }

  Future<FirebaseUser> createAccount(String mail, String pwd, String name, String surname) async {
    final FirebaseUser user = await auth_instance.createUserWithEmailAndPassword(email: mail, password: pwd);
    // Créer mon user pour l'ajouter dans la bdd
    String uid = user.uid;
    List<dynamic> followers = [uid];
    List<dynamic> following = [];
    Map<String, dynamic> map = {
      keyName: name,
      keySurname: surname,
      keyImageUrl: "",
      keyFollowers: followers,
      keyFollowing: following,
      keyUid: uid,
    };
    addUser(uid, map);
    return user;
  }

  logOut() => auth_instance.signOut();



  //DATABASE
  static final data_instance = Firestore.instance;
  final fire_user = data_instance.collection("users");
  final fire_notif = data_instance.collection("notifications");

  Stream<QuerySnapshot> postsFrom(String uid) => fire_user.document(uid).collection("posts").snapshots();

  addNotification(String from, String to, String text, DocumentReference ref, String type) {
    Map<String, dynamic> map = {
      keyUid: from,
      keyText: text,
      keyType: type,
      keyRef: ref,
      keySeen: false,
      keyDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    fire_notif.document(to).collection("singleNotif").add(map);
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.document(uid).setData(map);
  }

  modifyUser(Map<String, dynamic> data) {
    fire_user.document(me.uid).updateData(data);
  }

  modifyPicture(File file) {
    StorageReference ref = storage_user.child(me.uid);
    addImage(file, ref).then((finalised) {
      Map<String, dynamic> data = {keyImageUrl: finalised};
      modifyUser(data);
    });
  }

  addFollow(User other) {
    if (me.following.contains(other.uid)) {
      me.ref.updateData({keyFollowing: FieldValue.arrayRemove([other.uid])});
      other.ref.updateData({keyFollowers: FieldValue.arrayRemove([me.uid])});
    } else {
      me.ref.updateData({keyFollowing: FieldValue.arrayUnion([other.uid])});
      other.ref.updateData({keyFollowers: FieldValue.arrayUnion([me.uid])});
      addNotification(me.uid, other.uid, "${me.surname} a commencé à vous suivre", me.ref, keyFollowers);
    }
  }

  addLike(Post post) {
    if (post.likes.contains(me.uid)) {
      post.ref.updateData({keyLikes: FieldValue.arrayRemove([me.uid])});
    } else {
      post.ref.updateData({keyLikes: FieldValue.arrayUnion([me.uid])});
      addNotification(me.uid, post.userId, "${me.surname} a aimé votre post", post.ref, keyLikes);
    }
  }

  addPost(String uid, String text, File file) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyLikes: likes,
      keyComments: comments,
      keyDate: date
    };
    if (text != null && text != "") {
      map[keyText] = text;
    }
    if (file != null) {
      StorageReference ref = storage_posts.child(uid).child(date.toString());
      addImage(file, ref).then((finalised) {
        String imageUrl = finalised;
        map[keyImageUrl] = imageUrl;
        fire_user.document(uid).collection("posts").document().setData(map);
      });
    } else {
      fire_user.document(uid).collection("posts").document().setData(map);
    }
  }

  addComment(DocumentReference ref, String text, String postOwner) {
    Map<dynamic, dynamic> map = {
      keyUid: me.uid,
      keyText: text,
      keyDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    ref.updateData({keyComments: FieldValue.arrayUnion([map])});
    addNotification(me.uid, postOwner, "${me.surname} a commenté votre post", ref, keyComments);
  }


  //STORAGE
  static final storage_instance = FirebaseStorage.instance.ref();
  final storage_user = storage_instance.child("users");
  final storage_posts = storage_instance.child("posts");

  Future<String> addImage(File file, StorageReference ref) async {
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;
  }
*/
}