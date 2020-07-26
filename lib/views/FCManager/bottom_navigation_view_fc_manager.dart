import 'dart:ui';

import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/FoodCourtReportDBService/background_auto_generate_report_service.dart';
//import 'package:fcfoodcourt/shared/profile_view.dart';
import 'package:fcfoodcourt/views/profileViews/profile_view.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/manage_staff_view.dart';
import 'package:fcfoodcourt/views/FCManager/ReportView/select_type_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'VendorsView/vendor_management_view.dart';

class FoodCourtManagerNavBar extends StatefulWidget {
  final User userData;
  const FoodCourtManagerNavBar({Key key, this.userData}) : super(key: key);
  @override
  _FoodCourtManagerNavBarState createState() => _FoodCourtManagerNavBarState();
}

class _FoodCourtManagerNavBarState extends State<FoodCourtManagerNavBar> {
  int currentIndex;
  final List<Widget> children = [];
  @override
  void initState() {
    currentIndex = 0;
    children.add(VendorManagementView());
    children.add(ManageStaffView());

    children.add(SelectTypeView());

    children.add(ProfileView());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final User userData =  Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: children[currentIndex],
      bottomNavigationBar:Container(
        height: 75,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 4, color: Colors.black),
            )),
        child: BottomNavigationBar(
          onTap: (index) async{
            await Workmanager.initialize(callbackDispatcher);
            if(index == 2){
              await Workmanager.registerPeriodicTask(
                "Create monthly report for food court", 
                "auto-generating food court monthly report",
                frequency: Duration(minutes: 15),
                inputData: <String, dynamic>{
                  'databaseID': userData.id
                }
              );
            }
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
          iconSize: 25,
          backgroundColor: Color(0xffff8a84),
          selectedFontSize: 20,
          unselectedFontSize: 20,
          currentIndex: currentIndex,
          selectedLabelStyle: TextStyle(
            //color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
          //showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.black, size: 25),
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color(0xffff8a84),
                icon: Icon(Icons.restaurant),
                title: Text("Vendors"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.work),
              title: Text("Staff"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.report),
              title: Text("Report"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),
      ),

    );
  }
}
