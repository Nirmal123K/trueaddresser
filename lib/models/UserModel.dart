class UserModel{
  String uid;
  String phoneNumber; 
  String username;
  String isAcoountPrivate;
  String address;
  DateTime timestamp;
  UserModel({this.phoneNumber, this.uid, this.username,this.address,this.timestamp,this.isAcoountPrivate});
  
  Map toMap(UserModel user) { 
    var data = Map<String, dynamic>(); 
  
    data["uid"] = user.uid; 
    data["username"] = user.username; 
    data["phoneNumber"] = user.phoneNumber; 
    data["timestamp"] = user.timestamp;
    data["address"] = user.address;
    data["isAcoountPrivate"] = user.isAcoountPrivate;
  
    return data; 
  } 
  
  UserModel.fromMap(Map<String, dynamic> mapData) { 
    this.uid = mapData["uid"]; 
    this.username = mapData["username"]; 
    this.phoneNumber = mapData["phoneNumber"]; 
    this.address = mapData["address"];
    this.isAcoountPrivate = mapData["isAcoountPrivate"];
  } 
}