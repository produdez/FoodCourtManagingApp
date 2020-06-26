

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */

import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/popUpForms/new_staff_view.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/staff_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageStaffView extends StatefulWidget {
  final User userData; // userData passed down by the userRouter
  const ManageStaffView({Key key, this.userData}) : super(key: key);
  @override
  _ManageStaffViewState createState() => _ManageStaffViewState();
}

class _ManageStaffViewState extends State<ManageStaffView> {
  @override
  void initState() {
    super.initState();
    //set owner id
    StaffDBService.ownerID = widget.userData.id;
  }

  @override
  Widget build(BuildContext context) {
    String place = widget.userData.role ==  "Vendor Manager" ? "VENDOR" : "FOOD COURT";
    return StreamProvider<List<Staff>>.value(
      value: StaffDBService().allStaffsOfOwner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "$place STAFF LIST",
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
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 4, color: Colors.black),
              )),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 25,
            backgroundColor: Color(0xffff8a84),
            selectedFontSize: 20,
            unselectedFontSize: 20,
            currentIndex: 0,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant),
                  title: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                title: Text("Staff"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                title: Text("Report"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffff8a84), width: 4),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                        hintText: '   Search....'),
                  ),
                ),
                Icon(Icons.search, size: 50, color: Color(0xffff8a84)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: StaffListView()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffff8a84),
          onPressed: () {
            //On newDish chosen, show newDish popUp and process information
            //The return value is a Dish with name, price (every other fields are defaulted)
            createPopUpNewStaff(context).then((onValue) {
              if (onValue != null) {
                StaffDBService().addStaff(onValue);
              }
            }); //This request the pop-up new dish form
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
