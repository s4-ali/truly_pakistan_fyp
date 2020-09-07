import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplaceRepository{

  Future<List<DocumentSnapshot>> getMarketplaceItems(int categoryStartRange,int categoryEndRange)async{
    return (await FirebaseFirestore.instance
        .collection("Marketplace")
        .where("status",isLessThanOrEqualTo: categoryEndRange)
        .where("status",isGreaterThanOrEqualTo: categoryStartRange)
//        .orderBy("postedAt")
        .get()).docs;
  }

}