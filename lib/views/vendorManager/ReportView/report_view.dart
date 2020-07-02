import 'package:flutter/material.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/models/DailyVendorReport.dart';
//import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';

class ReportView extends StatefulWidget{
  final User userData;
  final String date;
  const ReportView(this.date, {this.userData});
  @override 
  _ReportViewState createState() => _ReportViewState(this.date);
}

class _ReportViewState extends State<ReportView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  static String previousDate = "Please choose the date!!";
  static String previousMonth = "Please choose the month!!";
  static List<Order> previousOrders;
  static List<DailyVendorReport> previousReport;
  String date;
  int reportType;
  _ReportViewState(this.date);
  //DataTable for monthly report
  Widget monthlyTable() {
    if(reportType == 1)
      previousReport = monthlyReport;
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
  Widget dailyTable() { 
    if(reportType == 0)
      previousOrders = orders;
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
      previousDate = date;
      return Text(
        date,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
    }
    return Text(
        previousDate,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
  }
  Widget checkNewMonth() {
    if(reportType == 1)
    {
      previousMonth = date;
      return Text(
        date,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
    }
    return Text(
        previousMonth,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.center,
      );
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: reportType = checkReportType(this.date), vsync: this, length: 2);
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
          actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
              onPressed: () async {
                await AuthenticationService().signOut();
              },)
          ],
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
              physics: const ScrollPhysics(),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        child: checkNewDate(),
                        width: previousDate == "Please choose the date!!" ? 300 : 125,                        
                      ),
                    ]
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(scrollDirection: Axis.vertical, child: previousDate == "Please choose the date!!" ? null : dailyTable(),)
                      )
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        padding: EdgeInsets.only(top: 20),
                        height: 50,
                        child: checkNewMonth(),
                        width: previousMonth == "Please choose the month!!" ? 300 : 125,                        
                      ),
                    ]
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
int checkReportType(String  date)
{
  reportType = 0;
  if(date.length < 9)
    reportType = 1;
  return reportType;
}
}

var orders = <Order> [
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
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),
  Order("Pho", "40.000 VND", "4", "160.000 VND"),
  Order("Hu Tieu", "40.000 VND", "4", "160.000 VND"),
  Order("Bun Bo Hue", "40.000 VND", "4", "160.000 VND"),
  Order("Mi Quang", "40.000 VND", "4", "160.000 VND"),
];

var monthlyReport = <DailyVendorReport>[
  DailyVendorReport("1/1/2020", "8.000.000 VND"),
  DailyVendorReport("2/1/2020", "8.000.000 VND"),
  DailyVendorReport("3/1/2020", "8.000.000 VND"),
  DailyVendorReport("4/1/2020", "8.000.000 VND"),
];

