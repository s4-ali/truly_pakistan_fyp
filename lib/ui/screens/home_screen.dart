import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/ui/screens/community_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace_screen.dart';
import 'file:///C:/Projects/Flutter/truly_pakistan_fyp/lib/ui/screens/travelogue/news_feed_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
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
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      NewsFeedScreen(),
      CommunityScreen(),
      MarketplaceScreen(),
      ProfileScreen(),
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
        navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
      ),
    );
  }


}
