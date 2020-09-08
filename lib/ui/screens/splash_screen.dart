import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/core/authentication.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/auth/flutter_login.dart';
import 'package:truly_pakistan_fyp/ui/screens/home_screen.dart';


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _showSplashScreen=true;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    setState(() {
      _showSplashScreen=false;
    });
//    final User user = authService.currentUser();
//    if(user==null){
//
//    }else{
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
    var messaging=FirebaseMessaging();
    messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: (_showSplashScreen)?
      _splashScreenWidget():StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_,snap){
          User user=snap.data;
          if(snap.connectionState==ConnectionState.waiting){
            return _splashScreenWidget();
          }else{
            if(user==null){
              Provider.of<UserProvider>(context).clearUser();
              return _authScreen();
            }else{
              startHomeScreen(user.uid);
              return _splashScreenWidget();
            }
          }
        },
      ),
    );
  }

  Widget _authScreen(){
    Authentication authService=Authentication();
    return FlutterLogin(
        onLogin: (s) async {
          try {
            await authService.signInWithEmailAndPassword(s.name, s.password);
            startHomeScreen(authService.currentUser().uid);
          } on PlatformException catch(e){
            return e.message;
          } on Exception catch(e) {
            return e.toString();
          }
          return null;
        },
        onSignup: (s)async{
          try{
            await authService.createUserWithEmailAndPassword(s.name, s.password, "Asfar");
            startHomeScreen(authService.currentUser().uid);
          } on PlatformException catch(e){
            return e.message;
          } on Exception catch(e) {
            return e.toString();
          }
          return null;
        },
        onRecoverPassword: (s)async{
          try {
            await authService.resetPassword(s);
          } on PlatformException catch(e){
            return e.message;
          } on Exception catch(e) {
            return e.toString();
          }
          return null;
        },
      );
  }

  Widget _splashScreenWidget(){
    return Center(
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
    );
  }

  void startHomeScreen(String uid) async{
    var userProvider=Provider.of<UserProvider>(context);
    await userProvider.changeUserTo(uid);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)
        =>HomeScreen(userProvider.getCurrentUser())));
  }
}
