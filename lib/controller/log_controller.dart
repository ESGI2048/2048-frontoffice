import 'package:augarde_2048/controller/bdd_helper.dart';
import 'package:augarde_2048/view/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:augarde_2048/view/my_material.dart';
import 'package:augarde_2048/controller/alert_helper.dart';
//import 'package:flutter_social/util/fire_helper.dart';

class LogController extends StatefulWidget {

  _LogState createState() => _LogState();
}

class _LogState extends State<LogController> {

  PageController _pageController;
  TextEditingController _login, _pwd;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _login = TextEditingController();
    _pwd = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _login.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          //Notification Received
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: InkWell(
            onTap: (() => hideKeyboard()),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height >= 650.0) ? MediaQuery.of(context).size.height : 650.0,
              decoration: MyGradient(startColor: base, endColor: baseAccent),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    PaddingWith(widget: Image(image: logoImage, height: 100.0,), top: 20.0, bottom: 20.0,),
                    PaddingWith(widget: Menu2Items(item1: "Connexion", item2: "Inscription", pageController: _pageController), top: 20.0, bottom: 20.0,),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[logView(0), logView(1)],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logView(int index) {
    return Column(
      children: <Widget>[
        PaddingWith(
          widget: Card(
            elevation: 7.5,
            color: white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listItems(),
              ),
            ),
          ),
          top: 15.0, bottom: 15.0, left: 20.0, right: 20.0,
        ),
        PaddingWith(
          widget: ButtonGradient(callback: (() => signIn((index == 0))), text: (index == 0) ? "Se connecter" : "Créer un compte"),
          top: 15.0, bottom: 15.0,
        ),
      ],
    );
  }


  List<Widget> listItems() {
    List<Widget> list = [];
    list.add(MyTextField(controller: _login, hint: "Entrez votre pseudo", ));
    list.add(MyTextField(controller: _pwd, hint: "Entrez votre mot de passe", obscure: true,));
    return list;
  }

  signIn(bool exists) {
    hideKeyboard();
    if (_login.text != null && _login.text != "") {
      if (_pwd.text != null && _pwd.text != "") {
        if (exists) {
          //Connexion avec mail et pwd
          signInUser();
         // FireHelper().signIn(_mail.text, _pwd.text);
        } else {
          //Inscription
          signUpUser();
          //FireHelper().createAccount(_mail.text, _pwd.text, _name.text, _surname.text);
        }
      } else {
        //Alerte pas de pwd
        AlertHelper().error(context, "Aucun mot de passe");
      }
    } else {
      //Alerte pas de mail
      AlertHelper().error(context, "Aucun pseudo");
    }
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  signUpUser() async {
    var res = await BddHelper().postUserSignUp(_login.text, _pwd.text);
    if (res) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  signInUser() async {
    var res = await BddHelper().getUserLogin(_login.text);
    if (res) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

}