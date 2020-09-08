import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/providers/search/search_provider.dart';
import 'package:truly_pakistan_fyp/ui/widgets/product_search_result_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/question_search_result_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_search_result_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/user_search_result_widget.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<String> tabsTitle=List();
  bool isSearchDone=false;
  String query="";

  @override
  void initState() {
    tabsTitle=List();
    tabsTitle.add("Travelogues");
    tabsTitle.add("Questions");
    tabsTitle.add("Products");
    tabsTitle.add("Users");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> containers = [
      TravelogueSearchResultWidget(),
      QuestionSearchResultWidget(),
      ProductSearchResultWidget(),
      UserSearchResultWidget(),
    ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          automaticallyImplyLeading: false,
          leading: isSearchDone?IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back,
              color: getTextColor(context),
            ),
          ):null,
//          elevation: 0,
          title: isSearchDone
              ? Text(query,style: TextStyle(color: getTextColor(context)),)
              : Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (query){
                Provider.of<SearchProvider>(context,listen: false).performQuery(query);
                setState(() {
                  isSearchDone=true;
                  this.query=query;
                });
              },
            ),
          ),
          actions: isSearchDone?[
            IconButton(
              onPressed: (){
                setState(() {
                  isSearchDone=false;
                });
              },
              icon: Icon(Icons.search,color: getTextColor(context),),
            ),
          ]:null,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity,60),
            child: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).textTheme.bodyText1.color,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Theme.of(context).canvasColor,
              ),
              tabs: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Travelogues',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Questions',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Products',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Tab(
                      text: 'Users',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}


