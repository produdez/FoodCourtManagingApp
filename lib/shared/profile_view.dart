
/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ProfileView extends StatefulWidget {
  final User userData; // userData passed down by the userRouter
  const ProfileView({Key key, this.userData}) : super(key: key);
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffff8a84),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await AuthenticationService().signOut();
            },)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Text("Name: ",
                    style: TextStyle(
                        color: Color(0xffffa834),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),),
                  Text("${widget.userData.name}",
                    style: TextStyle(
                        color: Color(0xffffa834),
                        fontSize: 40.0,
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Role:",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),),
                  Text("${widget.userData.role}",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30.0,
                       ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Email:",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("${widget.userData.email}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.0,
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("UID: ${widget.userData.id}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

