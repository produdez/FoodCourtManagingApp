
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/FCManager/VendorsView/vendor_management_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'vendor_list_view.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Vendor button
 */
class VendorManagementView extends StatefulWidget {
  @override
  _VendorManagementViewState createState() => _VendorManagementViewState();
}

class _VendorManagementViewState extends State<VendorManagementView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Vendor>>.value(
      value: VendorDBService().allVendor,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "FC VENDORS",
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
            Expanded(child: VendorListView()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffff8a84),
          onPressed: () =>VendorManagementViewController.addVendor(context),
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}

