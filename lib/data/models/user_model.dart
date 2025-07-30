class UserModel{
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;
  String ? photo;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.photo
  });


  UserModel.fromJson(Map<String,dynamic> jsonData){
    id=jsonData["_id"];
    email=jsonData["email"];
    firstName=jsonData["firstName"];
    lastName=jsonData["lastName"];
    mobile=jsonData["mobile"];
    photo=jsonData["photo"];

  }

  Map<String,dynamic> toJson(){
    return {
      "_id":id,
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
      "photo":photo,
    };

  }

  // "_id": "687cb925b4f34e7d4b421645",
  // "email": "amir@gmail.com",
  // "firstName": "amir",
  // "lastName": "hamja",
  // "mobile": "01799214895",
  // "createdDate": "2025-07-16T06:07:55.534Z"
}