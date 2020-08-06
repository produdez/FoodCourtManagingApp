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
import 'package:fcfoodcourt/services/search_service.dart';

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
    StaffDBService.ownerID = userData.role == 'Vendor Manager'
        ? userData == null ? null : userData.databaseID
        : userData.id;
    String place = userData.role == "Vendor Manager" ? "VENDOR" : "FC";
    return StreamProvider<List<Staff>>.value(
      value: StaffDBService().allStaffsOfOwner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "$place STAFF",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await AuthenticationService().signOut();
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    showSearch(context: context, delegate: SearchForStaff());
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffff8a84), width: 3),
                      ),
                      child: IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,
                                  size: 30, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: '   Search....',
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.grey)),
                        ),
                      )),
                ),
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
          onPressed: () =>
              ManageStaffViewController.addStaff(context), //onNewStaffSelected
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
