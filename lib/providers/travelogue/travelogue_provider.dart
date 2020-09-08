import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_comment_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/repository/travelogue/travelogue_repository.dart';

class TravelogueProvider extends ChangeNotifier{
  TravelogueRepository _travelogueRepository;
  List<TraveloguePostModel> _traveloguePosts;
  bool _refresh=false;

  TravelogueProvider(){
    _travelogueRepository=TravelogueRepository();
    loadTraveloguePosts();
  }

  List<TraveloguePostModel> getTraveloguePosts() => _traveloguePosts;

  Future<String> addTraveloguePost(TraveloguePostModel communityPostModel) async {
    var response=await _travelogueRepository.addTraveloguePost(communityPostModel.toMap());
    refreshTraveloguePosts();
    return response;
  }

  void loadTraveloguePosts() {
    if(_traveloguePosts==null||_refresh)
      _traveloguePosts=List();
    _travelogueRepository.getTraveloguePosts().then((value){
      _traveloguePosts.clear();
      for(DocumentSnapshot doc in value){
        if(doc.id!="_template") {
          _traveloguePosts.add(TraveloguePostModel().fromMap(doc.data())..id=doc.id);
        }
      }
      _refresh=false;
      notifyListeners();
    });
  }

  void refreshTraveloguePosts(){
    _refresh=true;
    loadTraveloguePosts();
  }

  Future loadCommentsFor(TraveloguePostModel traveloguePostModel)async{
    var answerDocs=await _travelogueRepository.getTravelogueCommentsFor(traveloguePostModel.id);
    List<TravelogueCommentModel> comments=List();
    for(var doc in answerDocs){
      comments.add(TravelogueCommentModel().fromMap(doc.data())..id=doc.id);
    }
    traveloguePostModel.comments=comments;
    return;
  }

  Future addNewCommentTo(TraveloguePostModel traveloguePostModel,TravelogueCommentModel comment)async{
    await _travelogueRepository.addAnswerTo(traveloguePostModel.id, comment.toMap());
    traveloguePostModel.comments.insert(0,comment);
  }

  Future addReactionTo(TraveloguePostModel traveloguePostModel)async{
    await _react(1, traveloguePostModel);
  }

  Future removeReactionTo(TraveloguePostModel traveloguePostModel)async{
    await _react(0, traveloguePostModel);
  }

  Future _react(int reaction,TraveloguePostModel traveloguePostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    await _travelogueRepository.reactOnPost(
        traveloguePostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'reaction':reaction,
        });
  }

  Future<List<TraveloguePostModel>> getTraveloguePostsByUser(UserModel user) async{
    var docs=await _travelogueRepository.getTraveloguePostsBy(user.uid);
    List<TraveloguePostModel> travelogues=List();
    for(DocumentSnapshot dc in docs){
      travelogues.add(TraveloguePostModel().fromMap(dc.data()));
    }
    return travelogues;
  }

  Future<TraveloguePostModel> getTravelogueById(String docId)async {
    DocumentSnapshot doc=await _travelogueRepository.getTraveloguePostsById(docId);
    return TraveloguePostModel().fromMap(doc.data())..id=docId;
  }

}