import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/core/media_uploader.dart';
import 'package:truly_pakistan_fyp/models/image_upload_task.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class EditProfileScreen extends StatefulWidget {

  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserProvider _userProvider;

  bool _editName=false;
  bool _editPhone=false;
  bool _editBio=false;
  bool _uploadingProfilePicture=false;
  bool _uploadingCoverPicture=false;

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _bioController;

  @override
  void initState() {
    _userProvider=Provider.of<UserProvider>(context,listen: false);
    _nameController=TextEditingController()
      ..text=_userProvider.getCurrentUser().name;
    _phoneController=TextEditingController()
      ..text=_userProvider.getCurrentUser().phoneNumber;
    _bioController=TextEditingController()
      ..text=_userProvider.getCurrentUser().bio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text("Edit Profile",style: TextStyle(color: Theme.of(context).primaryColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _getCoverImageWidget(),
            _getNameWidget(),
            Container(
              width: width,
              height: 1,
              color: Colors.black26,
            ),
            _getPhoneWidget(),
            Container(
              width: width,
              height: 1,
              color: Colors.black26,
            ),
            _getBioWidget(),
            Container(
              width: width,
              height: 1,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );

  }

  Widget _getNameWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: _editName? TextField(
              controller: _nameController,
              style: TextStyle(fontSize: 17),
              decoration: InputDecoration(
                hintText: "Name",
                border: InputBorder.none,
              ),
            ): Text(_userProvider.getCurrentUser().name??"",style: TextStyle(fontSize: 17),),
          ),
          if(_editName)IconButton(
            onPressed: (){
              setState(() {
                _editName=false;
                _nameController.text=_userProvider.getCurrentUser().name;
              });
            },
            icon: Icon(Icons.clear),
          ),
          if(_editName)IconButton(
            onPressed: (){
              setState(() {
                Provider.of<UserProvider>(context,listen: false).updateName(_nameController.text);
                _userProvider.getCurrentUser().name=_nameController.text;
                _editName=false;
              });
            },
            icon: Icon(Icons.check),
          ),
          if(!_editName)IconButton(
            onPressed: (){
              setState(() {
                _editName=true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _getPhoneWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child:_editPhone?  TextField(
              controller: _phoneController,
              style: TextStyle(fontSize: 17),
              decoration: InputDecoration(
                hintText: "Phone Number",
                border: InputBorder.none,
              ),
            ) : Text(_userProvider.getCurrentUser().phoneNumber??"",style: TextStyle(fontSize: 17),),
          ),
          if(_editPhone)IconButton(
            onPressed: (){
              setState(() {
                _editPhone=false;
                _phoneController.text=_userProvider.getCurrentUser().phoneNumber;
              });
            },
            icon: Icon(Icons.clear),
          ),
          if(_editPhone)IconButton(
            onPressed: (){
              setState(() {
                Provider.of<UserProvider>(context,listen: false).updatePhoneNumber(_phoneController.text);
                _userProvider.getCurrentUser().phoneNumber=_phoneController.text;
                _editPhone=false;
              });
            },
            icon: Icon(Icons.check),
          ),
          if(!_editPhone)IconButton(
            onPressed: (){
              setState(() {
                _editPhone=true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _getBioWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child:_editBio?  TextField(
              controller: _bioController,
              style: TextStyle(fontSize: 17),
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Bio",
                border: InputBorder.none,
              ),
            ) : Text(_userProvider.getCurrentUser().bio??"",style: TextStyle(fontSize: 17),),
          ),
          if(_editBio)IconButton(
            onPressed: (){
              setState(() {
                _editBio=false;
                _bioController.text=_userProvider.getCurrentUser().bio;
              });
            },
            icon: Icon(Icons.clear),
          ),
          if(_editBio)IconButton(
            onPressed: (){
              setState(() {
                Provider.of<UserProvider>(context,listen: false).updateBio(_bioController.text);
                _userProvider.getCurrentUser().bio = _bioController.text;
                _editBio=false;
              });
            },
            icon: Icon(Icons.check),
          ),
          if(!_editBio)IconButton(
            onPressed: (){
              setState(() {
                _editBio=true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _getCoverImageWidget(){
    var width=MediaQuery.of(context).size.width;
    return Container(
        height: width/2,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 3,offset: Offset(0,3))],
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _userProvider.getCurrentUser().imageUrlCover!=null?CachedNetworkImage(
                  imageUrl: _userProvider.getCurrentUser().imageUrlCover,
                  height: width-16,
                  width: width-16,
                  fit: BoxFit.fill,
                ):Image.asset(
                  "name",
                  height: width-16,
                  width: width-16,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _getProfileImageWidget(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: (_uploadingCoverPicture)?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ):IconButton(
                  splashColor: Colors.white,
                  onPressed: _updateCoverImage,
                  icon:Icon(Icons.edit,color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget _getProfileImageWidget() {
    var width=MediaQuery.of(context).size.width;
    return Container(
        width: width/3,
        height: width/3,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 3,offset: Offset(0,3))],
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _userProvider.getCurrentUser().imageUrl!=null?CachedNetworkImage(
                  imageUrl: _userProvider.getCurrentUser().imageUrl,
                  height: width/2,
                  width: width/2,
                  fit: BoxFit.fill,
                ):Image.asset(
                    "name",
                    height: width-16,
                    width: width-16,
                    fit: BoxFit.fill,
                  ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: (_uploadingProfilePicture)?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ):IconButton(
                  splashColor: Colors.white,
                  onPressed: _updateProfileImage,
                  icon:Icon(Icons.edit,color: Colors.white,),
                ),
              ),
            ),
          ],
        ),
      );
  }

  _updateCoverImage()async{
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: ImgSource.Both,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),//cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _uploadingCoverPicture=true;
    });
    var uploader=MediaUploader();
    var uploadTask=ImageUploadTask()
      ..path="CoverPictures"
      ..file=image;
    var result=await uploader.uploadSingleImage(uploadTask);
    if(result.exceptionMessage!=null){
      longToast("Failed to upload:${result.exceptionMessage}", context);
    }else{
      await Provider.of<UserProvider>(context,listen: false).updateCoverPicture(result.url);
      setState(() {
        _uploadingCoverPicture=false;
        _userProvider.getCurrentUser().imageUrlCover=result.url;
      });
    }
  }

  _updateProfileImage()async{
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: ImgSource.Both,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),//cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _uploadingProfilePicture=true;
    });
    var uploader=MediaUploader();
    var uploadTask=ImageUploadTask()
      ..path="ProfilePictures"
      ..file=image;
    var result=await uploader.uploadSingleImage(uploadTask);
    if(result.exceptionMessage!=null){
      longToast("Failed to upload:${result.exceptionMessage}", context);
    }else{
      await Provider.of<UserProvider>(context,listen: false).updateProfilePicture(result.url);
      setState(() {
        _uploadingProfilePicture=false;
        _userProvider.getCurrentUser().imageUrl=result.url;
      });
    }
  }
}