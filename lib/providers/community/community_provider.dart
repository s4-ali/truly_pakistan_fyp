import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/repository/community/community_repository.dart';

class CommunityProvider extends ChangeNotifier{
  CommunityRepository _communityRepository;
  List<CommunityPostModel> communityPosts;

  CommunityProvider(){
    _communityRepository=CommunityRepository();
    loadCommunityPosts();
  }

  List<CommunityPostModel> getCommunityPosts() => communityPosts;

  Future<String> addCommunityPost(CommunityPostModel communityPostModel) async {
    return _communityRepository.addCommunityPost(communityPostModel.toMap());
  }

  void loadCommunityPosts() {
    if(communityPosts==null)
      communityPosts=List();
    _communityRepository.getCommunityPosts().then((value){
      communityPosts.clear();
      for(DocumentSnapshot doc in value){
        communityPosts.add(CommunityPostModel().fromMap(doc.data));
      }
      notifyListeners();
    });
  }

  void refreshCommunityPosts(){
    loadCommunityPosts();
  }
}