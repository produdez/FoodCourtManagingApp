import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'image_upload_service.dart';

/*
This class deal with updating/fetching user data to/from the DB
This class can create/get user data from DB, just remember to use this by:
  UserDBService(<user Id here>).someFunction(parameters);
 */

class UserDBService {

  final String id; //should be static but it's too late for that :D
  String role;
  UserDBService(this.id);

  // collection reference
  final CollectionReference userDB = Firestore.instance.collection('users');

  Future<void> setUserData({String name, String email, String role, String password}) async {
    return await userDB.document(this.id).setData({
      'id': this.id,
      'name': name,
      'email': email,
      'role': role,
      'password': password,
    });
  }

  //password change
  Future<void> changePassword({String newPassword}) async {
    return await userDB.document(this.id).updateData({
      'password': newPassword,
    });
  }

  Future uploadProfileImage(File image) async {
    DocumentReference userInstance = userDB.document(id);
     ImageUploadService().uploadPic(image,userInstance);
     return await userInstance.updateData({
       'hasImage' : true,
     });
  }

  // user data from snapshots
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        id :snapshot.data['id'] ?? null,
        name: snapshot.data['name'] ?? null,
        email: snapshot.data['email'] ?? null,
        role: snapshot.data['role'] ?? null,
      password: snapshot.data['password'] ?? null,
      hasImage: snapshot.data['hasImage'] ?? false,
      imageURL: snapshot.data['imageURL'] ?? null,
      databaseID: snapshot.data['manageID'] ?? null,
    );
  }

  //get StaffDB snapshot stream, this stream will auto-update if DB have change and notify any listener
  Stream<User> get user {
    return userDB.snapshots().map(_singleUserdataFromSnapshot);
  }

  //Mapping a database snapshot into a staffList, but only staffs of the user (vendor) that's currently logged in
  User _singleUserdataFromSnapshot(QuerySnapshot snapshot) {
    DocumentSnapshot snap = snapshot.documents
        .firstWhere((DocumentSnapshot documentSnapshot) =>
    documentSnapshot.data['id'] == id);
      return _userDataFromSnapshot(snap);
  }

  //Use this to fetch user data from DB
  Future<User> getUserData() async {
    User user;
    await userDB.document(id).get().then((onValue){
      user = _userDataFromSnapshot(onValue);
    });
    return user;
  }

  Future setDatabaseID(String databaseID) async {
    DocumentReference _userRef = userDB.document(id);
    return await _userRef.updateData({
      'databaseID' : databaseID,
    });
  }

}