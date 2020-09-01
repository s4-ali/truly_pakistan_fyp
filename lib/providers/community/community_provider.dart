import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/community/community_answer_model.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/repository/community/community_repository.dart';

class CommunityProvider extends ChangeNotifier{
  CommunityRepository _communityRepository;
  List<CommunityPostModel> _communityPosts;

  CommunityProvider(){
    _communityRepository=CommunityRepository();
    loadCommunityPosts();
  }

  List<CommunityPostModel> getCommunityPosts() => _communityPosts;

  Future<String> addCommunityPost(CommunityPostModel communityPostModel) async {
    return _communityRepository.addCommunityPost(communityPostModel.toMap());
  }

  void loadCommunityPosts() {
    if(_communityPosts==null)
      _communityPosts=List();
    _communityRepository.getCommunityPosts().then((value){
      _communityPosts.clear();
      for(DocumentSnapshot doc in value){
        if(doc.id!="_template") {
          _communityPosts.add(CommunityPostModel().fromMap(doc.data())..id=doc.id);
        }
      }
      notifyListeners();
    });
  }

  void refreshCommunityPosts(){
    loadCommunityPosts();
  }

  Future loadAnswersFor(CommunityPostModel communityPostModel)async{
    var answerDocs=await _communityRepository.getCommunityAnswersFor(communityPostModel.id);
    List<CommunityAnswerModel> answers=List();
    for(var doc in answerDocs){
      answers.add(CommunityAnswerModel().fromMap(doc.data())..id=doc.id);
    }
    communityPostModel.answers=answers;
    return;
  }

  Future addNewAnswerTo(CommunityPostModel communityPostModel,CommunityAnswerModel answer)async{
    await _communityRepository.addAnswerTo(communityPostModel.id, answer.toMap());
    communityPostModel.answers.insert(0,answer);
  }

  Future addUpVoteTo(CommunityPostModel communityPostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    _communityRepository.voteOnPost(
        communityPostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'vote':1,
        });
  }
  Future removeVoteTo(CommunityPostModel communityPostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    _communityRepository.voteOnPost(
        communityPostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'vote':0,
        });
  }
  Future addDownVoteTo(CommunityPostModel communityPostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    _communityRepository.voteOnPost(
        communityPostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'vote':-1,
        });
  }
}