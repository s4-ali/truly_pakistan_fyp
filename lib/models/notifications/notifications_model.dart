class NotificationModel{
  String type;
  String docId;
  String title;
  String body;
  String icon;

  NotificationModel fromMap(Map<String,dynamic> map){
    this.type=map["type"];
    this.docId=map["docId"];
    this.title=map["title"];
    this.body=map["body"];
    if(map["icon"] is String)
      this.icon=map["icon"];
    return this;
  }
}