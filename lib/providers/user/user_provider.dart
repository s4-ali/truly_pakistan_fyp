import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/repository/user/user_repository.dart';

class UserProvider extends ChangeNotifier{

  UserModel _userModel;
  UserRepository _userRepository;
  bool _isUserLoaded=false;

  UserProvider(){
    _userModel=UserModel()..isCurrentUser=true;
    _userRepository=UserRepository();
  }

  UserModel getCurrentUser() => _userModel;

  Future<UserModel> _loadUserInformation()async{
      var info = await _userRepository.getUserInfo(_userModel.uid);
      _isUserLoaded=true;
      return _userModel.fromMap(info);
  }

  Future<String> updateName(String text) async{
    FirebaseAuth.instance.currentUser.updateProfile(displayName: text);
    var info={"name":text};
    _userModel.name=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updatePhoneNumber(String text) async{
    var info={"phoneNumber":text};
    _userModel.phoneNumber=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateBio(String text) async{
    var info={"bio":text};
    _userModel.bio=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateProfilePicture(String url)async {
    FirebaseAuth.instance.currentUser.updateProfile(photoURL: url);
    var info={"profilePicture":url};
    _userModel.imageUrl=url;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateCoverPicture(String url) async{
    var info={"coverPicture":url};
    _userModel.imageUrlCover=url;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future changeUserTo(String uid) async{
    _userModel.clear();
    _userModel.uid=uid;
    _userModel.isCurrentUser=true;
    _isUserLoaded=false;
    await _loadUserInformation();
    notifyListeners();
  }

  void clearUser() {
    _isUserLoaded=false;
    _userModel.clear();
    notifyListeners();
  }

  Future<UserModel> getUserDetails(UserModel user)async{
    var info = await _userRepository.getUserInfo(user.uid);
    if(info==null)return user;
    return user.fromMap(info);
  }

  Future<bool> isCurrentUserFollowing(String otherUid) async{
    var doc=await _userRepository.getFollowingDocument(_userModel.uid,otherUid);
    if(doc!=null&&doc.exists)
      return true;
    return false;
  }

  Future<String> unFollowUser(UserModel user)  async{
    return await _userRepository.removeFromFollowing(_userModel.uid,user.uid);
  }

  Future<String> followUser(UserModel user) async{
    return await _userRepository.addFollowing(_userModel.uid,user.uid,{"name":user.name,"imageUrl":user.imageUrl});
  }

  Future<List<UserModel>> getFollowingsOf(UserModel user) async{
    var docs=await _userRepository.getFollowingOf(user.uid);
    List<UserModel> users=List();
    for(DocumentSnapshot doc in docs){
      users.add(UserModel().fromMap(doc.data()));
    }
    return users;
  }

  Future<List<UserModel>> getFollowersOf(UserModel user) async{
    var docs=await _userRepository.getFollowerOf(user.uid);
    List<UserModel> users=List();
    for(DocumentSnapshot doc in docs){
      users.add(UserModel().fromMap(doc.data()));
    }
    return users;
  }

  Future<String> updateCountry(String text) async {
    var info={"country":text};
    _userModel.country=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateState(String text) async{
    var info={"state":text};
    _userModel.state=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateCity(String text) async{
    var info={"city":text};
    _userModel.city=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateFacebookUrl(String text) async{
    var info={"facebookURL":text};
    _userModel.facebookURL=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

  Future<String> updateTwitter(String text) async{
    var info={"twitterURL":text};
    _userModel.twitterURL=text;
    notifyListeners();
    return await _userRepository.updateUserInfo(info, _userModel.uid);
  }

}