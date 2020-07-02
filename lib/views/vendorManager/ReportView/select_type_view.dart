import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/choose_date_view.dart';
import 'package:intl/intl.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/choose_month_view.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/report_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class SelectTypeView extends StatefulWidget {
  final User userData;
  const SelectTypeView({this.userData});
  @override
  _SelectTypeViewState createState() => _SelectTypeViewState();
}

class _SelectTypeViewState extends State<SelectTypeView> {
  DateTime _dateTime;
  String formattedDate;
  String formattedMonth;
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
          )
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
              .then((onValue){
                if(onValue != null){
                  formattedDate = DateFormat('dd/MM/yyyy').format(onValue);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => ReportView(formattedDate))
                  );
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
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => ReportView(formattedMonth))
                  );
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