import 'package:flutter/material.dart';
import 'package:augarde_2048/model/user.dart';

// User Global
User me;

//Colors
const int gridBackground = 0xFFa2917d;
const int gridColorTwoFour = 0xFFeee4da;
const int fontColorTwoFour = 0xFF766c62;
const int emptyGridBackground = 0xFFbfafa0;
const int gridColorEightSixtyFourTwoFiftySix = 0xFFf5b27e;
const int gridColorOneTwentyEightFiveOneTwo = 0xFFf77b5f;
const int gridColorSixteenThirtyTwoOneZeroTwoFour = 0xFFecc402;
const int gridColorWin = 0xFF60d992;
const int transparentWhite = 0x80FFFFFF;

const Color white = const Color(0xFFFFFFFF);
const Color base = const Color(0xFFBDBDBD);
const Color baseAccent = const Color(0xFF616161);
const Color pointer = const Color(0xFFF44336);



//Images
AssetImage logoImage = AssetImage("assets/logo_augarde.png");


//Icons
const Icon settingsIcon = Icon(Icons.settings);
const Icon refreshIcon = Icon(Icons.refresh, color: Colors.white70,);
const Icon eventIcon = Icon(Icons.event);


// Keys NodeJS
String keyName = "name";
String keySurname = "surname";
String keyImageUrl = "imageUrl";
String keyFollowers = "followers";
String keyFollowing = "following";
String keyUid = "uid";
String keyPostId = "postID";
String keyText = "text";
String keyDate = "date";
String keyLikes = "likes";
String keyComments = "comments";
String keyDescription = "description";
String keyType = "type";
String keyRef = "ref";
String keySeen = "seen";


