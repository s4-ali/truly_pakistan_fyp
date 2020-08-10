import 'package:flutter/material.dart';

import 'auth/flutter_login.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        onLogin: (s){
          Future.delayed(Duration(seconds: 1));
          Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
          return null;
        },
        onSignup: (s){return null;},
        onRecoverPassword: (s){return null;},
      ),
    );
  }
}
