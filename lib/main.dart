import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/chat/chat_provider.dart';
import 'package:truly_pakistan_fyp/providers/community/community_provider.dart';
import 'package:truly_pakistan_fyp/providers/marketplace/marketplace_provider.dart';
import 'package:truly_pakistan_fyp/providers/search/search_provider.dart';
import 'package:truly_pakistan_fyp/providers/theme_provider.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/splash_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/test_screen.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider<CommunityProvider>(
          create: (_) => CommunityProvider(),
        ),
        ChangeNotifierProvider<TravelogueProvider>(
          create: (_) => TravelogueProvider(),
        ),
        ChangeNotifierProvider<MarketPlaceProvider>(
          create: (_) => MarketPlaceProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  final bool isTest=false;

  Future<void> _initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _initializeDefault();
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_,theme,__){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme.currentThemeData,
            debugShowCheckedModeBanner: false,
            home: isTest?TestScreen():SplashScreen(),
          );
        },
      ),
    );
  }
}