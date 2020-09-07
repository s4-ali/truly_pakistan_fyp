
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';

import 'category_model.dart';

class PageModel{
  String pageTitle;
  List<MarketPlaceItemModel> featuredItems;
  List<CategoryModel> categories;
  List<MarketPlaceItemModel> adsList;

  PageModel({this.pageTitle,this.featuredItems,this.categories,this.adsList});
}