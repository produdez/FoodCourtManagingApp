import 'dart:async';

import 'package:fcfoodcourt/models/user.dart';
import 'package:intl/intl.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/invalid_view.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/report_view.dart';
import 'package:fcfoodcourt/models/vendor_report.dart';
import 'package:fcfoodcourt/shared/dialog_loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
void callbackDispatcher(){
    //print("initial");
    Workmanager.executeTask((taskName, inputData)async{
      // VendorReportDBService.vendorId = _getFirstUserId(widget.userData.id);
      switch (taskName) {
        case "simplePeriodic1HourTask":
          
          int day = int.parse(DateFormat('d').format(DateTime.now()));
          int month = int.parse(DateFormat('M').format(DateTime.now()));
          int year = int.parse(DateFormat('y').format(DateTime.now()));
          int hour = int.parse(DateFormat('H').format(DateTime.now()));
          var nextDate = new DateTime(year, month, day + 1);
          VendorReportDBService.vendorId = await _getFirstUserId(inputData['vendorId']);
          // print("${VendorReportDBService.vendorId}");
          // print("get in task");
          if(nextDate.day == 1 && hour >= 21)
            await VendorReportDBService().createMonthlyReport(DateFormat('MM/yyyy').format(DateTime.now()));
          break;
      }
      return Future.value(true);
    });
  }
_getFirstUserId(String userId) async{
    String firstUserId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('firstUserId') == null)
      prefs.setString('firstUserId', userId);
    firstUserId = prefs.getString('firstUserId');
    return firstUserId;
  }
class SelectTypeView extends StatefulWidget {
  final User userData;
  const SelectTypeView({this.userData});
  @override
  _SelectTypeViewState createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  String formattedDate;
  String formattedMonth;
  String formatId;
  int currentDay;
  int currentMonth;
  int currentYear;
  int currentHour;
  //const static simplePeriodicHourTask = "simplePeriodic1HourTask";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  
 @override
  void initState() {
    super.initState();
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
    VendorReportDBService.vendorId = widget.userData.id;
    // Check if it turns to new month => create monthly report of the latest month (each vendor may has different "latest month")
    int found = 0;
    // currentDay = int.parse(DateFormat('d').format(DateTime.now()));
    // currentMonth = int.parse(DateFormat('M').format(DateTime.now()));
    // currentYear = int.parse(DateFormat('y').format(DateTime.now()));
    // currentHour = int.parse(DateFormat('H').format(DateTime.now()));
    // Workmanager.initialize(
    //   //print("initialize"),
    //   callbackDispatcher,
    // );
    // setState(() async{
    // });+
    
    //VendorReportDBService.vendorId = widget.userData.id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //child: Scaffold(
        resizeToAvoidBottomInset: false, // address bottom overflow error
        //resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "VIEW REPORT",
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
        body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Row(
            children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  padding: EdgeInsets.only(top: 10),
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffff8a84), width: 4),
                  ),
                  child: Text(
                    'PLEASE CHOOSE REPORT TYPE',
                    style: TextStyle(
                      color: Color(0xffff8a84),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 85, 0, 75),
            child: SizedBox(
              width: 200,
              height: 100,
              child: reportType("Daily"),
            )
          ),
          //SizedBox(height: 50,),
          Container(
            child: SizedBox(
              width: 200,
              height: 100,
              child: reportType("Monthly"),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          FloatingActionButton(
          heroTag: "FAB1",
          backgroundColor: Color(0xffff8a84),
          onPressed: () {
                List<Order> emptyList;
                //print(VendorReportDBService.vendorId.toString());
                print("Create Daily Report");
                VendorReportDBService().createDailyReport(emptyList);
                //]);

            }, //This request the pop-up new dish form
          child: Icon(
            Icons.add,
            size: 50,
          ),
          ),
          FloatingActionButton(
          heroTag: "FAB2",
          backgroundColor: Color(0xffff8a84),
          onPressed: () {
            //On newDish chosen, show newDish popUp and process information
            //The return value is a Dish with name, price (every other fields are defaulted)
              print("Update Daily Report");
                VendorReportDBService().updateDailyReport(<Order>[Order(name: "pho", price: 400 , quantity: 1, revenue: 400 ),
                Order(name: "Hu tieu", price: 40, quantity: 2, revenue: 80 ), Order(name: "Bun Rieu", price: 40, quantity: 2, revenue: 80 )
                ]);

            }, //This request the pop-up new dish form
          child: Icon(
            Icons.add,
            size: 50,
          ),
          ),
          FloatingActionButton(
          heroTag: "FAB3",
          backgroundColor: Color(0xffff8a84),
          onPressed: () {
            //On newDish chosen, show newDish popUp and process information
            //The return value is a Dish with name, price (every other fields are defaulted)
              print("Create Monthly Report");
                VendorReportDBService().createMonthlyReport("072020");

            }, //This request the pop-up new dish form
          child: Icon(
            Icons.add,
            size: 50,
          ),
          ),
          FloatingActionButton(
          heroTag: "FAB4",
          backgroundColor: Color(0xffff8a84),
          onPressed: () async{
            //On newDish chosen, show newDish popUp and process information
            //The return value is a Dish with name, price (every other fields are defaulted)
              print("cancel task");
                //VendorReportDBService().createMonthlyReport("072020");
            await Workmanager.cancelAll();
            }, //This request the pop-up new dish form
          child: Icon(
            Icons.add,
            size: 50,
          ),
          ),
          ],)
          ]
        ),
        ],
        )
    );
    //  ),
  }
  Positioned reportType(String type) {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: RaisedButton(
          color: Color(0xffff8a84),
          child: new Text(
            type, 
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
          ),
          onPressed: () {
            if(type == 'Daily')
            {
              showDatePicker(
                context: context, 
                initialDate: DateTime.now(), 
                firstDate: DateTime(2020), 
                lastDate: DateTime(2030))
              .then((onValue) {
                if(onValue != null){
                  formattedDate = DateFormat('dd/MM/yyyy').format(onValue);
                  formatId = DateFormat('ddMMyyyy').format(onValue);
                  Dialogs.showLoadingDialog(context, _keyLoader);
                  VendorReportDBService().checkAvailableDailyReport(formatId).then((onValue){
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                    if(onValue != null)
                    {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ReportView(formattedDate, onValue, null))                    
                      );
                    }
                    else {
                      createPopUpInvalidMessage(context);
                    }
                  });
                }
              }
              );
            }
            if(type == 'Monthly')
            {
              showMonthPicker(
                context: context, 
                initialDate: DateTime.now(), 
                firstDate: DateTime(2020), 
                lastDate: DateTime(2030))
              .then((onValue){
                if(onValue != null){
                  formattedMonth = DateFormat('MM/yyyy').format(onValue);
                  formatId = DateFormat('MMyyyy').format(onValue);
                  Dialogs.showLoadingDialog(context, _keyLoader);
                  VendorReportDBService().checkAvailableMonthlyReport(formatId).then((onValue){
                    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                    if(onValue != null)
                    {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ReportView(formattedMonth, null, onValue))                    
                      );
                    }
                    else {
                      createPopUpInvalidMessage(context);
                    }
                  });
                }
              } 
              );
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0))
            ),
          ),
        );
  }
}