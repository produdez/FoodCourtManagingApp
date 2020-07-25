import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/models/vendor_report.dart';
import 'package:flutter/material.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/FoodCourtReportDBService/food_court_report_db_service.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/invalid_view.dart';
import 'package:fcfoodcourt/shared/dialog_loading_view.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
//import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';

class ReportView extends StatefulWidget{
  final User userData;
  final List<MonthlyVendorReport> monthlyVendorReportList;
  final String month;
  const ReportView(this.month, this.monthlyVendorReportList, {this.userData});
  @override 
  _ReportViewState createState() => _ReportViewState(this.month, this.monthlyVendorReportList);
}

class _ReportViewState extends State<ReportView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  double totalProceed;
  String month;
  String reportType;
  String formattedMonth;
  String formatId;
  List<MonthlyVendorReport> monthlyVendorReportList;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  _ReportViewState(this.month, this.monthlyVendorReportList);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    totalProceed = FoodCourtReportDBService().calculateTotalProceed(monthlyVendorReportList);
  }
  Widget printTotalProceed(String totalProceed){
    return Container(                      
            width: 350,
            height: 75,
            decoration: BoxDecoration(border: Border.all(
              color: Color(0xffff8a84), 
              width: 4
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 75,
                  width: 170,
                  color: Colors.white,
                  child: Text(
                    "Total Proceed",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 75,
                  width: 172,
                  padding: EdgeInsets.only(top: 20),
                  color: Color(0xffff8a84),
                  child: Text(
                    "$totalProceed\ VND",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
        )
  );
  }
  Widget monthlyTable(){
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Vendor",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            "Sale",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
            "Commission\n(4%)",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
            "Rent",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
            "Total Paid",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
      ],
      rows: monthlyVendorReportList
        .map(
          (report) => DataRow(cells: [
            DataCell(
              Text("LOL"),
            ),
            DataCell(
              Text("${report.sale}"),
            ),
            DataCell(
              Text("${report.sale * 0.04}"),
            ),
            DataCell(
              Text("5m VND"),
            ),
            DataCell(
              Text("total"),
            ),
          ]))
        .toList()
    );
  }
  Widget changeTime(String type){
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: RaisedButton(
        color: Color(0xffff8a84),
        child: Text(
          type, 
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: (){
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
              FoodCourtReportDBService().checkAvailableMonthlyReport(formatId).then((onValue){
                Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
                if(onValue != null)
                {
                  Navigator.pushReplacement(
                   context, 
                  MaterialPageRoute(builder: (context) => ReportView(formattedMonth, onValue))
                  );
                }
                else
                  createPopUpInvalidMessage(context);
                });          
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      //resizeToAvoidBottomInset: false, // address bottom overflow error
      //resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "VIEW REPORT",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(child: Text(
                  'Monthly',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        width: 130,
                        child: Text(
                          month,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        width: 270,
                        alignment: Alignment.centerRight,
                        child: changeTime("Choose Month")
                      )
                    ]
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: monthlyTable(),
                          ),
                      )
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: printTotalProceed("$totalProceed"),
                    ),
                    SizedBox(height: 25,)
                  ],
                ),
              ],
              controller: _tabController,
            )
          //],
          //)
      );
  }

}

