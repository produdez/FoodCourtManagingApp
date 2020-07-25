import 'dart:ui';
import 'package:fcfoodcourt/services/VendorReportDBService/background_auto_generate_report_service.dart';
import 'package:fcfoodcourt/shared/profile_view.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/select_type_view.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:workmanager/workmanager.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/manage_staff_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/menu_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class VendorManagerNavBar extends StatefulWidget {
  final User userData;
  const VendorManagerNavBar({Key key, this.userData}) : super(key: key);
  @override
  _VendorManagerNavBarState createState() => _VendorManagerNavBarState();
}

class _VendorManagerNavBarState extends State<VendorManagerNavBar> {
  int currentIndex;
  final List<Widget> children = [];
  @override
  void initState() {
    currentIndex = 0;
    children.add(MenuView(userData: widget.userData,));
    children.add(ManageStaffView(userData: widget.userData,));

    //TODO: Add report route here
    children.add(SelectTypeView(userData: widget.userData));
    
    children.add(ProfileView(userData: widget.userData,));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // address bottom overflow error
      //resizeToAvoidBottomPadding: false,
      body: children[currentIndex],
      bottomNavigationBar:Container(
        height: 75,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 4, color: Colors.black),
            )),
        child: BottomNavigationBar(
          onTap: (index)async{
            await Workmanager.initialize(callbackDispatcher);
            if(index == 2){
              print("here");
              //Workmanager.initialize(callbackDispatcher);
              await Workmanager.registerPeriodicTask(
                "Create monthly report for vendor", 
                "auto-generating vendor monthly report",
                frequency: Duration(minutes: 15),
                inputData: <String, dynamic>{
                  'vendorId': widget.userData.id
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
         // selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.black, size: 25),
          //selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color(0xffff8a84),
                icon: Icon(Icons.restaurant),
                title: Text("Menu"),
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
