import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

import 'marketplace/data.dart';
import 'marketplace/main.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  @override
  Widget build(BuildContext context) {
   return MarketPlace(pageModel: mainPageModel,);
  }
}
