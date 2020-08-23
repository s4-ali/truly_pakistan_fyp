import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/core/media_uploader.dart';
import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/models/image_upload_task.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';

import '../../../utils.dart';

class AddTravelogueScreen extends StatefulWidget {
  @override
  _AddTravelogueScreenState createState() => _AddTravelogueScreenState();
}

class _AddTravelogueScreenState extends State<AddTravelogueScreen> {

  List<File> imageFiles;
  List<String> tags;
  List<String> locations;

  TextEditingController descriptionController;
  TextEditingController tagController;
  TextEditingController locationController;

  bool addTagEnabled;
  bool addLocationEnabled;
  bool uploading;

  int uploadCount;

  @override
  void initState() {
    imageFiles=List();
    tags=["tag1","tag2"];//List();
    locations=["location1","location2"];//List();

    addTagEnabled=false;
    addLocationEnabled=false;
    uploading=false;

    descriptionController=TextEditingController();
    descriptionController.text="description test";
    tagController=TextEditingController();
    locationController=TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        title: Text("Ask Question",style: TextStyle(color: theme.primaryColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: theme.primaryColor,),
        ),
        actions: <Widget>[
          InkWell(
            onTap: onClickPost,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text("Ask",style: TextStyle(color: theme.primaryColor,fontSize: 15),)),
            ),
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _getAddMediaSection(),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "How may community help you?"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 8),
            child: Text("Tags",style: Theme.of(context).textTheme.headline6,),
          ),
          _getAddTagSection(),
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 8),
            child: Text("Locations",style: Theme.of(context).textTheme.headline6,),
          ),
          _getLocationSections(),
        ],
      ),
    );
  }

  Widget _getLocationSections(){
    return Container(
      height: 53,
      child: ListView.builder(
        itemBuilder: (_,index){
          if (locations.length!=index) {
            return Container(
              margin: EdgeInsets.only(left: 16,bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(locations[index],),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          locations.removeAt(index);
                        });
                      },
                      child: Icon(Icons.clear,),
                    ),
                  ],
                ),
              ),
            );
          }else{
            if(addLocationEnabled){
              return Container(
                height: 45,
                width: 150,
                margin: EdgeInsets.only(left: 16,bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .accentColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  onEditingComplete: (){
                    setState(() {
                      if(locationController.text.isNotEmpty)
                        locations.add(locationController.text);
                      locationController.clear();
                      addLocationEnabled=false;
                    });
                  },
                  controller: locationController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Location"
                  ),
                ),
              );
            }else {
              return GestureDetector(
                onTap: onTapAddLocation,
                child: Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.only(left: 16,bottom: 8,right: 16),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: 25,),
                  ),
                ),
              );
            }
          }
        },
        itemCount: locations.length+1,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getAddTagSection() {
    return Container(
      height: 53,
      child: ListView.builder(
        itemBuilder: (_,index){
          if (tags.length!=index) {
            return Container(
              margin: EdgeInsets.only(left: 16,bottom: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(tags[index],),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          tags.removeAt(index);
                        });
                      },
                      child: Icon(Icons.clear,),
                    ),
                  ],
                ),
              ),
            );
          }else{
            if(addTagEnabled){
              return Container(
                height: 45,
                width: 150,
                margin: EdgeInsets.only(left: 16,bottom: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .accentColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  onEditingComplete: (){
                    setState(() {
                      if(tagController.text.isNotEmpty)
                        tags.add(tagController.text);
                      tagController.clear();
                      addTagEnabled=false;
                    });
                  },
                  controller: tagController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter tag"
                  ),
                ),
              );
            }else {
              return GestureDetector(
                onTap: onTapAddTag,
                child: Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.only(left: 16,bottom: 8,right: 16),
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: 25,),
                  ),
                ),
              );
            }
          }
        },
        itemCount: tags.length+1,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _getAddMediaSection() {
    int imageCount=imageFiles.length;
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        itemBuilder: (_,index){
          if(index!=imageCount){
            return Container(
              margin: EdgeInsets.only(left: 16),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child:Image.file(
                        imageFiles[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                    if(uploading&&uploadCount<=index)Align(
                        alignment: Alignment.center,
                        child:Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black12,
                          ),
                        )
                    ),

                  ],
                ),
              ),
            );
          }else{
            return GestureDetector(
              onTap: ()async{
                getImage(ImgSource.Both);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16,right: 16),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Center(
                  child: Icon(Icons.add,color: Theme.of(context).textTheme.bodyText1.color,size: 50,),
                ),
              ),
            );
          }
        },
        itemCount: imageFiles.length+1,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Future getImage(ImgSource source) async {
    File image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),//cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    if(image==null)return
    print(image.path);
    setState(() {
      if(image!=null) {
        imageFiles.add(image);
      }
    });
  }

  void onClickPost() async{
    if(validInputFields()){
      setState(() {
        uploading=true;
        uploadCount=0;
      });
      if(imageFiles.isEmpty){
        _onImagesUploaded(null);
      }else{
        _uploadImages();
      }
    }
  }

  void onTapAddTag() {
    setState(() {
      addTagEnabled=true;
    });
  }

  void onTapAddLocation() {
    setState(() {
      addLocationEnabled=true;
    });
  }

  bool validInputFields() {
    if(descriptionController.text.isEmpty&&imageFiles.isEmpty){
      shortToast("Post is empty", context);
    }
    return true;
  }

  void _uploadImages() async {
    uploadCount=0;
    List<ImageUploadTask> imageUploadTasks=List();
    imageFiles.forEach((file) {
      var imageUploadTask=ImageUploadTask();
      imageUploadTask.file=file;
      imageUploadTask.path="path/to/file.png";
      imageUploadTasks.add(imageUploadTask);
    });
    List<String> urls=List();
    MediaUploader uploader=MediaUploader();
    if(imageFiles.length==0) {
      _onImagesUploaded(null);
      setState(() {
        uploading=false;
      });
      return null;
    }
    if(imageFiles.length==1) {
      var result=await uploader.uploadSingleImage(imageUploadTasks[0]);
      setState(() {
        uploading=false;
      });
      uploader.dispose();
      if(result.exceptionMessage==null){
        urls.add(result.url);
        _onImagesUploaded(urls);
      }
    } else{
      Stream stream=uploader.uploadMultipleImages(imageUploadTasks);
      stream.listen((result) {
        var imageUploadTask=result as ImageUploadTask;
        if (imageUploadTask.exceptionMessage != null &&
            imageUploadTask.exceptionMessage.isNotEmpty) {
          shortToast(imageUploadTask.exceptionMessage, context);
        } else {
          urls.add(imageUploadTask.url);
          setState(() {
            uploadCount++;
          });
        }
      }).onDone(() {
        _onImagesUploaded(urls);
      });
    }
  }

  void _onImagesUploaded(List<String> urls)async{
    var model=TraveloguePostModel();
    model.locations=locations;
    model.tags=tags;
    model.reacts=0;
    model.description=descriptionController.text;
    model.images=urls;
    UserModel user=UserModel();
    User firebaseUser=FirebaseAuth.instance.currentUser;
    user.name=firebaseUser.displayName;
    user.profileUrl=firebaseUser.photoURL;
    user.uid=firebaseUser.uid;
    model.postedAt=DateTime.now();
    model.user=user;
    model.totalComments=0;
    String result=await Provider.of<TravelogueProvider>(context,listen: false).addTraveloguePost(model);
    if(result==null||result.isEmpty){
      longToast("Uploaded Successfully", context);
      setState(() {
        imageFiles.clear();
        descriptionController.clear();
        tags.clear();
        tagController.clear();
        locations.clear();
        locationController.clear();
      });
      Navigator.of(context).pop();
    }else{
      print(result);
      longToast("Failed to upload", context);
    }
  }
}
