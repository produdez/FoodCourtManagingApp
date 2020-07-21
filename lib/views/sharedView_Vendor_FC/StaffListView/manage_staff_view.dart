

/*
This is the menu view that holds the frame for the whole staff management view
It does holds the add Staff button
 */

import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/manage_staff_view_controller.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/staff_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageStaffView extends StatefulWidget {
  const ManageStaffView({Key key}) : super(key: key);
  @override
  _ManageStaffViewState createState() => _ManageStaffViewState();
}

class _ManageStaffViewState extends State<ManageStaffView> {
  @override
  void initState() {
    super.initState();
    //set owner id
  }

  @override
  Widget build(BuildContext context) {
    final User userData = Provider.of<User>(context);
    StaffDBService.ownerID = userData.role =='Vendor Manager' ? userData==null?null:userData.manageID : userData.id;
    String place = userData.role ==  "Vendor Manager" ? "VENDOR" : "FC";
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
          onPressed: () => ManageStaffViewController.addStaff(context), //onNewStaffSelected
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
