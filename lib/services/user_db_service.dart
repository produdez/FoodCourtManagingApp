import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/user.dart';

/*
This class deal with updating/fetching user data to/from the DB
This class can create/get user data from DB, just remember to use this by:
  UserDBService(<user Id here>).someFunction(parameters);
 */

class UserDBService {

  final String id;
  String role;
  UserDBService(this.id);

  // collection reference
  final CollectionReference userDB = Firestore.instance.collection('users');

  Future<void> updateUserData({String name, String email, String role}) async {
    return await userDB.document(this.id).setData({
      'id': this.id,
      'name': name,
      'email': email,
      'role': role,
    });
  }

  // user data from snapshots
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        id :snapshot.data['id'] ?? null,
        name: snapshot.data['name'] ?? null,
        email: snapshot.data['email'] ?? null,
        role: snapshot.data['role'] ?? null,
    );
  }

  // get user doc stream
//  Stream<User> get userData{
//    return userDB.document(this.id).snapshots()
//        .map(_userDataFromSnapshot);
//  }

  //Use this to fetch user data from DB
  Future<User> getUserData() async {
    User user;
    await userDB.document(id).get().then((onValue){
      user = _userDataFromSnapshot(onValue);
    });
    return user;
  }

}