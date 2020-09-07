import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/repository/search/search_repository.dart';

class SearchProvider extends ChangeNotifier{
  SearchRepository _searchRepository;

  SearchProvider(){
    _searchRepository=SearchRepository();
  }

  Future<String> performQuery(String query)async{
    String uid=FirebaseAuth.instance.currentUser.uid;
    return await _searchRepository
        .performSearch(
        {
          "query":query,
          "searchedAt":FieldValue.serverTimestamp(),
        }, uid);
  }
}