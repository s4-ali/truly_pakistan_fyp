import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/repository/marketplace/marketplace_repository.dart';

const int CATEGORY_TOUR = 0;
const int CATEGORY_HOTEL = 1;
const int CATEGORY_TRANSPORT = 2;
const int CATEGORY_GUIDES = 3;
const int CATEGORY_TICKETS = 4;
const int CATEGORY_CLOTHING = 5;
const int CATEGORY_EQUIPMENTS = 6;
const List<int> ALL_CATEGORIES = [0,1,2,3,4,5,6];
const List<int> SERVICES = [0,1,2,3,4];
const List<int> GOODS = [5,6];

class MarketPlaceProvider extends ChangeNotifier{
  MarketplaceRepository _marketplaceRepository;

  MarketPlaceProvider(){
    _marketplaceRepository=MarketplaceRepository();
  }

  Future<List<MarketPlaceItemModel>> getAllMarketplaceItems() async {
    List<MarketPlaceItemModel> items=List();
    for(DocumentSnapshot doc in (await _marketplaceRepository.getMarketplaceItems(0, 6))){
      items.add(MarketPlaceItemModel().fromMap(doc.data()));
    }
    return items;
  }



}

extension Filter on List<MarketPlaceItemModel>{

  List<MarketPlaceItemModel> filterItemsByCategory(List<int> categories){
    List<MarketPlaceItemModel> filteredItems=List();
    for(MarketPlaceItemModel item in this){
      var shouldAdd=false;
      for(int category in categories){
        if(shouldAdd=category==item.status)
          break;
      }
      if(shouldAdd)
        filteredItems.add(item);
    }
    return filteredItems;
  }

}
