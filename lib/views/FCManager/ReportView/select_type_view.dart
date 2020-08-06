import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/FoodCourtReportDBService/food_court_report_db_service.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/invalid_view.dart';
import 'package:fcfoodcourt/views/FCManager/ReportView/report_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/shared/dialog_loading_view.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

class SelectTypeView extends StatefulWidget {
  const SelectTypeView();
  @override
  _SelectTypeViewState createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  String formattedMonth;
  String formatId;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  void initState() {
    super.initState();

    // int hour = int.tryParse(DateFormat('H').format(DateTime.now()));
    // String firstLogginDate = DateFormat('d').format(DateTime.now());
    // /*if(FoodCourtReportDBService.currentMonth == null)
    //   FoodCourtReportDBService.currentMonth = DateFormat('MMyyyy').format(DateTime.now());*/
    // if(FoodCourtReportDBService.currentMonth != null){
    //   if(FoodCourtReportDBService.currentMonth != DateFormat('MMyyyy').format(DateTime.now())){
    //     if(firstLogginDate == "01" && hour < 12)
    //       FoodCourtReportDBService.currentMonth = DateFormat('MMyyyy').format(DateTime.now());
    //     else
    //       FoodCourtReportDBService().createMonthlyReport(DateFormat('MMyyyy').format(DateTime.now()));
    //   }
    //   //FoodCourtReportDBService.currentMonth = DateFormat('MMyyyy').format(DateTime.now());
    // }
    // FoodCourtReportDBService.currentMonth = DateFormat('MMyyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final User userData = Provider.of<User>(context);
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
    FoodCourtReportDBService.foodCourtId = userData.id;
    print(FoodCourtReportDBService.foodCourtId);
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
              },
            )
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        padding: EdgeInsets.only(top: 10),
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffff8a84), width: 4),
                        ),
                        child: Text(
                          'PLEASE CHOOSE REPORT TYPE',
                          style: TextStyle(
                              color: Color(0xffff8a84),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Stack(children: [reportType("Monthly")]),
                    ),
                  ),
                  // FloatingActionButton(
                  // heroTag: "FAB4",
                  // backgroundColor: Color(0xffff8a84),
                  // onPressed: () async{
                  //   //On newDish chosen, show newDish popUp and process information
                  //   //The return value is a Dish with name, price (every other fields are defaulted)
                  //     print("cancel task");
                  //       //VendorReportDBService().createMonthlyReport("072020");
                  //   await Workmanager.cancelAll();
                  //   }, //This request the pop-up new dish form
                  // child: Icon(
                  //   Icons.add,
                  //   size: 50,
                  // ),
                  // ),
                  // FloatingActionButton(
                  // heroTag: "FAB3",
                  // backgroundColor: Color(0xffff8a84),
                  // onPressed: () async{
                  //   //On newDish chosen, show newDish popUp and process information
                  //   //The return value is a Dish with name, price (every other fields are defaulted)
                  //     print("generate food court report");
                  //       //VendorReportDBService().createMonthlyReport("072020");
                  //   await FoodCourtReportDBService().createMonthlyReport("072020");
                  //   }, //This request the pop-up new dish form
                  // child: Icon(
                  //   Icons.add,
                  //   size: 50,
                  // ),
                  // ),
                ]),
          ],
        ));
    //  ),
  }

  Positioned reportType(String type) {
    return Positioned.fill(
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
              if (type == 'Monthly') {
                showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030))
                    .then((onValue) {
                  if (onValue != null) {
                    formattedMonth = DateFormat('MM/yyyy').format(onValue);
                    formatId = DateFormat('MMyyyy').format(onValue);
                    Dialogs.showLoadingDialog(context, _keyLoader);
                    FoodCourtReportDBService()
                        .checkAvailableMonthlyReport(formatId)
                        .then((onValue) {
                      Navigator.of(_keyLoader.currentContext,
                              rootNavigator: true)
                          .pop();
                      if (onValue != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReportView(formattedMonth, onValue)));
                      } else
                        createPopUpInvalidMessage(context);
                    });
                  }
                });
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
      ),
    );
  }
}
