import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/core/authentication.dart';
import 'package:truly_pakistan_fyp/ui/screens/auth/flutter_login.dart';
import 'package:truly_pakistan_fyp/ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    Authentication authService=Authentication();
    final User user = authService.currentUser();
    if(user==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>FlutterLogin(
        onLogin: (s) async {
          try {
            await authService.signInWithEmailAndPassword(s.name, s.password);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          } on Exception catch(e){
            return e.toString();
          }
          return null;
        },
        onSignup: (s)async{
          try{
            await authService.createUserWithEmailAndPassword(s.name, s.password, "Asfar");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }on Exception catch(e){
            return e.toString();
          }
          return null;
        },
        onRecoverPassword: (s)async{
          try {
            await authService.resetPassword(s);
          } on Exception catch(e){
            print(e);
            return e.toString();
          }
          return null;
        },
      ),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Truly Pakistan", style: TextStyle(fontSize: 24,color: Colors.white),),
//            new Image.asset(
//              "assets/icons&splashs/launcher.png",
//              width: 100 ,
//              height: 100,
//              fit: BoxFit.cover,
//            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
