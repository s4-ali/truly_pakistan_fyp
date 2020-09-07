import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/providers/marketplace/marketplace_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/models/category_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/models/page_model.dart';

import 'main.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {

  PageModel _pageModel;

  @override
  void initState() {
    loadMainPageModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   return _pageModel==null
       ? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),)
       : MarketPlace(pageModel: _pageModel,);
  }

  void loadMainPageModel() async {
    var marketplace=Provider.of<MarketPlaceProvider>(context,listen: false);
    List<MarketPlaceItemModel> allItems=await marketplace.getAllMarketplaceItems();
    var featuredItems=allItems.filterItemsByCategory(ALL_CATEGORIES);
    var servicesItems=allItems.filterItemsByCategory(SERVICES);
    var goodsItems=allItems.filterItemsByCategory(GOODS);
    var mainPageModel=PageModel(
      pageTitle:"MarketPlace",
      featuredItems: featuredItems,
      categories: [
        CategoryModel(
          categoryTitle: "Services",
          categoryAds: servicesItems,
        ),
        CategoryModel(
          categoryTitle: "Goods",
          categoryAds: goodsItems,
        ),
      ],
      adsList: allItems,
    );
    setState(() {
      this._pageModel=mainPageModel;
    });
  }
}
