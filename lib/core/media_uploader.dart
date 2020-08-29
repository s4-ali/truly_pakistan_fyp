import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:truly_pakistan_fyp/models/image_upload_task.dart';
import 'package:uuid/uuid.dart';

class MediaUploader{

  StreamController<ImageUploadTask> controller = StreamController<ImageUploadTask>();

  Future<ImageUploadTask> uploadSingleImage(ImageUploadTask imageUploadTask)async{
    try {
      imageUploadTask.path=imageUploadTask.path+Uuid().v1().toString()+".jpg";
      var result=await FirebaseStorage.instance.ref().child(imageUploadTask.path).putFile(imageUploadTask.file).onComplete;
      imageUploadTask.url=await result.ref.getDownloadURL();
      return imageUploadTask;
    }on PlatformException catch(ex){
      imageUploadTask.exceptionMessage=ex.message;
      return imageUploadTask;
    }on Exception catch(ex){
      imageUploadTask.exceptionMessage="Invalid error occurred";
      return imageUploadTask;
    }
  }

  Stream<ImageUploadTask> uploadMultipleImages(List<ImageUploadTask> imageUploadTasks){
    Future.forEach(imageUploadTasks, (ImageUploadTask imageUploadTask) async {
      try {
        imageUploadTask.path=imageUploadTask.path+Uuid().v1().toString()+".jpg";
        var result=await FirebaseStorage.instance.ref().child(imageUploadTask.path).putFile(imageUploadTask.file).onComplete;
        imageUploadTask.url=await result.ref.getDownloadURL();
        controller.add(imageUploadTask);
        if(_isLastTask(imageUploadTask,imageUploadTasks))
          controller.close();
      }on PlatformException catch(ex){
        imageUploadTask.exceptionMessage=ex.message;
        controller.add(imageUploadTask);
        if(_isLastTask(imageUploadTask,imageUploadTasks))
          controller.close();
      }on Exception catch(_){
        imageUploadTask.exceptionMessage="Invalid Error Occurred";
        controller.add(imageUploadTask);
        if(_isLastTask(imageUploadTask,imageUploadTasks))
          controller.close();
      }
    });
    return controller.stream;
  }

  void dispose(){
    controller.close();
  }

  bool _isLastTask(ImageUploadTask imageUploadTask, List<ImageUploadTask> imageUploadTasks) {
    return imageUploadTasks.last==imageUploadTask;
  }

}