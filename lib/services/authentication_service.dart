import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/user_db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
Authentication service, dealing with just log-in and sign-up
This class can return current user's id only (if needed)
It also push user's data to storage when user register
 */

class AuthenticationService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    if(user!= null){
      return User(id: user.uid);
    }
    return null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({String email, String password,String name, String role}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await UserDBService(user.uid).setUserData(name: name, email: email, role: role, password: password);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //get current user's id
  Future<String> getCurrentUserID() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  //change password
  Future<bool> changePassword(String newPassword) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      await user.updatePassword(newPassword);
      UserDBService(user.uid).changePassword(newPassword: newPassword);
      print("Changed password:"+ newPassword);
      return true;
    } on Exception catch (e) {
      print('Error, password not changed! Re login required!');
      print(e.toString());
      return false;
    }
  }

  //check if password provided is current with the current password.
  Future<bool> checkCorrectPassword(String oldPassword,String newPassword) async{
      FirebaseUser user = await _auth.currentUser();
      print('Testing email ${user.email}, password $newPassword');
      bool result = newPassword == oldPassword;
      if(result==true) print("Old Password:"+ newPassword);
      else print("Wrong password");
      return result;
    }
}