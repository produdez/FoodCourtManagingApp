
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/invalid_view.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';
import 'package:fcfoodcourt/models/DailyVendorReport.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
//import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';

class ReportView extends StatefulWidget{
  final User userData;
  final String date;
  final List<Order> orders;
  final List<DailyVendorReport> dailyVendorReport;
  const ReportView(this.date, this.orders, this.dailyVendorReport, {this.userData});
  @override 
  _ReportViewState createState() => _ReportViewState(this.date, this.orders, this.dailyVendorReport);
}

class _ReportViewState extends State<ReportView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  static String previousDate = "Please choose the date!!";
  static String previousMonth = "Please choose the month!!";
  static List<Order> previousOrders;
  static List<DailyVendorReport> previousReport;
  static int stupidBug = 0;
  String date;
  int reportType;
  String formattedDate;
  String formattedMonth;
  String formatId;
  List<Order> orders;
  List<DailyVendorReport> dailyVendorReport;
  //var orderss;
  _ReportViewState(this.date, this.orders, this.dailyVendorReport);
  @override
  void initState() {
    super.initState();
    reportType = checkReportType(date);
    _tabController = TabController(initialIndex: reportType, vsync: this, length: 2);
    if(reportType == 0)
      previousOrders = orders;
    else
      previousReport = dailyVendorReport;

  }
  //DataTable for monthly report
  Widget monthlyTable() {
    /*if(reportType == 1)
      previousReport = dailyVendorReport;*/
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
          'Date',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Sale',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        )
      ],
      rows: previousReport
        .map(
          (report) => DataRow(cells: [
            DataCell(
              Text(report.date),
            ),
            DataCell(
              Text(report.sale),
            ),
          ])
        ).toList()
    );
  }
  //DataTable for daily report
  Widget dailyTable(){ 
    /*if(reportType == 0)
      previousOrders = orders;*/
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
          'Orders',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Quantity',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Price',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Revenue',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
      ],
      rows: previousOrders
        .map(
          (order) => DataRow(cells: [
            DataCell(
              Text(order.name),
            ),
            DataCell(
              Text(order.quantity),
            ),
            DataCell(
              Text(order.price),
            ),
            DataCell(
              Text(order.revenue),
            )
          ])        
        ).toList()
    );
  }
  Widget checkNewDate() {
    if(reportType == 0)
    {
      previousDate = ' $date';
      return Text(
        ' $date',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.start,
      );
    }
    return Text(
        previousDate,
        style: TextStyle(
          color: Colors.black87,
          fontSize:  previousDate == "Please choose the date!!" ? 30 : 20,
          fontWeight: FontWeight.bold
        ),
        textAlign:  previousDate == "Please choose the date!!" ? TextAlign.center : TextAlign.start,
      );
  }
  Widget checkNewMonth() {
    if(reportType == 1)
    {
      previousMonth = ' $date';
      return Text(
        ' $date',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.start,
      );
    }
    return Text(
        previousMonth,
        style: TextStyle(
          color: Colors.black87,
          fontSize: previousMonth == "Please choose the month!!" ? 30 : 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: previousMonth == "Please choose the month!!" ? TextAlign.center : TextAlign.start,
      );
  }
  Widget changeTime(String type){
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: RaisedButton(
          color: Color(0xffff8a84),
          child: new Text(
            type, 
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            if(type == 'Choose Date')
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
                  VendorReportDBService().checkAvailableDailyReport(formatId, 'vendor1').then((onValue) {
                    if(onValue != null)
                    {
                      Navigator.pushReplacement(
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
            if(type == 'Choose Month')
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
                  VendorReportDBService().checkAvailableMonthlyReport(formatId, 'vendor1').then((onValue) async{
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
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false, // address bottom overflow error
      resizeToAvoidBottomPadding: false,
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
                  'Daily',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ),
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
          //automaticallyImplyLeading: false,
        ),
        body: TabBarView(
              //physics: const ScrollPhysics(),
              children: <Widget>[
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [               
                    Row(
                    children: [
                      // date or message
                      Container(
                        margin: EdgeInsets.only(top: previousDate == "Please choose the date!!" && reportType != 0 ? 150 : 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        //alignment: previousDate == "Please choose the date!!" ? Alignment.center : Alignment.centerLeft,
                        child: checkNewDate(),
                        width: previousDate == "Please choose the date!!" ? 400 : 130,                        
                      ),
                      // If there is already a searched daily report
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        width: previousDate == "Please choose the date!!" ? 0 : 270,
                        alignment: Alignment.centerRight,
                        child: previousDate == "Please choose the date!!" ? null : changeTime("Choose Date")
                      )
                    ]
                    ),
                    // if there is not any searched daily report
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: previousDate != "Please choose the date!!" ? 0 : 20),
                          padding: EdgeInsets.only(top: previousDate != "Please choose the date!!" ? 0 : 20),
                          height: previousDate != "Please choose the date!!" ? 0 : 75,
                          width: previousDate != "Please choose the date!!" ? 0 : 200,
                          alignment: Alignment.center,
                          child: previousDate != "Please choose the date!!" ? null : SizedBox(
                            width: 200,
                            height: 100,
                            child: changeTime("Choose Date")
                          )  
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: previousDate == "Please choose the date!!" ? null : dailyTable(),)
                      )
                    )
                  ],
                ),
                // MONTHLY REPORT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: previousMonth == "Please choose the month!!" && reportType != 1 ? 150 : 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        alignment: previousMonth == "Please choose the month!!" ? Alignment.center : Alignment.centerLeft,
                        child: checkNewMonth(),
                        width: previousMonth == "Please choose the month!!" ? 400 : 125,                        
                      ),
                      // If there is already a searched monthly report
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        width: previousMonth == "Please choose the month!!" ? 0 : 275,
                        alignment: Alignment.centerRight,
                        child: previousMonth == "Please choose the month!!" ? null : changeTime("Choose Month")
                      )
                    ]
                    ),
                    // if there is not any searched monthly report
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: previousMonth != "Please choose the month!!" ? 0 : 20),
                          padding: EdgeInsets.only(top: previousMonth != "Please choose the month!!" ? 0 : 10),
                          height: previousMonth != "Please choose the month!!" ? 0 : 75,
                          width: previousMonth != "Please choose the month!!" ? 0 : 200,
                          child: previousMonth != "Please choose the month!!" ? null : SizedBox(
                            width: 200,
                            height: 100,
                            child: changeTime("Choose Month")
                          ),
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: previousMonth == "Please choose the month!!" ? null : monthlyTable())
                      )
                    )
                  ],
                ),
              ],
              controller: _tabController,
            ),
      );
  }
  /*Widget dailyTable(){ 
    if(reportType == 0){
      previousOrders = this.orders;
      print("Here");
    }
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
          'Orders',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Quantity',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Price',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
        DataColumn(
          label: Text(
          'Revenue',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          )
        ),
      ],
      rows: previousOrders
        .map(
          (order) => DataRow(cells: [
            DataCell(
              Text(order.name),
            ),
            DataCell(
              Text(order.quantity),
            ),
            DataCell(
              Text(order.price),
            ),
            DataCell(
              Text(order.revenue),
            )
          ])        
        ).toList()
    );
  }*/
int checkReportType(String  date)
{
  reportType = 0;
  if(date.length < 9)
    reportType = 1;
  return reportType;
}

}

var orderss = <Order> [
  /*Order("Pho", "40.000 VND", "4", "160.000 VND"),
  Order("Hu Tieu", "40.000 VND", "4", "160.000 VND"),
  Order("Bun Bo Hue", "40.000 VND", "4", "160.000 VND"),
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),
  Order("Pho", "40.000 VND", "4", "160.000 VND"),
  Order("Hu Tieu", "40.000 VND", "4", "160.000 VND"),
  Order("Bun Bo Hue", "40.000 VND", "4", "160.000 VND"),
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),
  Order("Pho", "40.000 VND", "4", "160.000 VND"),
  Order("Hu Tieu", "40.000 VND", "4", "160.000 VND"),
  Order("Bun Bo Hue", "40.000 VND", "4", "160.000 VND"),
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),
  Order("Pho", "40.000 VND", "4", "160.000 VND"),
  Order("Hu Tieu", "40.000 VND", "4", "160.000 VND"),
  Order("Bun Bo Hue", "40.000 VND", "4", "160.000 VND"),
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),*/
];
var monthlyReport = <DailyVendorReport>[
  DailyVendorReport(),
  /*DailyVendorReport("2/1/2020", "8.000.000 VND"),
  DailyVendorReport("3/1/2020", "8.000.000 VND"),
  DailyVendorReport("4/1/2020", "8.000.000 VND"),*/
];

