import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/chat/chat_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/notifications_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/travelogue_screen.dart';

import 'community/community_screen.dart';

class HomeScreen extends StatefulWidget {

  final user;
  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PersistentTabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {

    var activeColor=Colors.white;
    var inactiveColor=Colors.black.withAlpha(120);

    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.group),
        title: ("Community"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Marketplace"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notification"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      TravelogueScreen(),
      CommunityScreen(),
      MarketplaceScreen(),
      NotificationsScreen(),
      Consumer<UserProvider>(
        builder: (_,value,__){
          Provider.of<ChatProvider>(context,listen: false).init(value.getCurrentUser());
          return ProfileScreen(user: value.getCurrentUser(),);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).primaryColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style13,
        onItemSelected: onItemSelected,// Choose the nav bar style with this property.
      ),
    );
  }



  void onItemSelected(int value) {
    if(value==4){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
    }else{
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }
}
