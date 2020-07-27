import 'dart:io';

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  final String databaseID;

  final String password; //for debug only
  String imageURL;

  bool hasImage;
  File imageFile;

  User({this.id, this.name, this.email, this.role,this.hasImage=false,this.imageURL,this.imageFile, this.password,this.databaseID});

  User.clone({User user, this.id, this.name, this.email, this.role, this.password,this.databaseID}) {
    // password //debug only
    this.hasImage = user.hasImage;
    this.imageURL = user.imageURL;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, role: $role, imageURL: $imageURL, hasImage: $hasImage, imageFile: $imageFile, manageID: $databaseID}';
  }

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['fullName'],
        email = data['email'],
        role = data['userRole'],
        databaseID = data['manageID'],
        password = data['password']; //debug only
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': name,
      'email': email,
      'userRole': role,
      'password': password, //debug only
    };
  }
}