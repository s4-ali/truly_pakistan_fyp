
import 'ad_model.dart';
import 'category_model.dart';

class PageModel{
  String pageTitle;
  List<AdModel> featuredItems;
  List<CategoryModel> categories;
  List<AdModel> adsList;

  PageModel({this.pageTitle,this.featuredItems,this.categories,this.adsList});
}