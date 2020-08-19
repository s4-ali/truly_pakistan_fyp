import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/providers/theme_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/community/community_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/home_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/settings_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/splash_screen.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_,theme,__){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: Provider.of<ThemeProvider>(context).currentThemeData,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}