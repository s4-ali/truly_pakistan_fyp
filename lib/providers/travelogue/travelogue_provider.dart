import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_comment_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/repository/travelogue/travelogue_repository.dart';

class TravelogueProvider extends ChangeNotifier{
  TravelogueRepository _travelogueRepository;
  List<TraveloguePostModel> _traveloguePosts;

  TravelogueProvider(){
    _travelogueRepository=TravelogueRepository();
    loadTraveloguePosts();
  }

  List<TraveloguePostModel> getTraveloguePosts() => _traveloguePosts;

  Future<String> addTraveloguePost(TraveloguePostModel communityPostModel) async {
    return _travelogueRepository.addTraveloguePost(communityPostModel.toMap());
  }

  void loadTraveloguePosts() {
    if(_traveloguePosts==null)
      _traveloguePosts=List();
    _travelogueRepository.getTraveloguePosts().then((value){
      _traveloguePosts.clear();
      for(DocumentSnapshot doc in value){
        if(doc.id!="_template") {
          _traveloguePosts.add(TraveloguePostModel().fromMap(doc.data())..id=doc.id);
        }
      }
      notifyListeners();
    });
  }

  void refreshCommunityPosts(){
    loadTraveloguePosts();
  }

  Future loadAnswersFor(TraveloguePostModel traveloguePostModel)async{
    var answerDocs=await _travelogueRepository.getTravelogueCommentsFor(traveloguePostModel.id);
    List<TravelogueCommentModel> comments=List();
    for(var doc in answerDocs){
      comments.add(TravelogueCommentModel().fromMap(doc.data())..id=doc.id);
    }
    traveloguePostModel.comments=comments;
    return;
  }

  Future addNewAnswerTo(TraveloguePostModel traveloguePostModel,TravelogueCommentModel comment)async{
    await _travelogueRepository.addAnswerTo(traveloguePostModel.id, comment.toMap());
    traveloguePostModel.comments.insert(0,comment);
  }

  Future addReactionTo(TraveloguePostModel traveloguePostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    _travelogueRepository.reactOnPost(
        traveloguePostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'react':0,
        });
  }

  Future removeReactionTo(TraveloguePostModel traveloguePostModel)async{
    var fUser=FirebaseAuth.instance.currentUser;
    _travelogueRepository.reactOnPost(
        traveloguePostModel.id,
        fUser.uid,
        {'imageUrl':fUser.photoURL,
          'name':fUser.displayName,
          'react':1,
        });
  }

}