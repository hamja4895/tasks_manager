class TaskStatusCountModel{
  late String id;
  late int count;

  TaskStatusCountModel.fromJson(Map<String,dynamic> json){
    id=json["_id"];
    count=json["sum"];

  }

}