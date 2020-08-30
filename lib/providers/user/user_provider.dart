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
    return user.fromMap(info);
  }

}