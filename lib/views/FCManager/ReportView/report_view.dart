import 'package:flutter/material.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
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
  String date;
  String reportType;
  _ReportViewState(this.date);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
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
              /*Tab(child: Text(
                  'Daily',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ),*/
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
                        width: 125,
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      /*child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,*/
                      child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Vendor',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            )
                        ),
                        DataColumn(
                          label: Text(
                            'Sale',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        ),
                        DataColumn(
                          label: Text(
                            'Rent',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        ),
                        DataColumn(
                          label: Text(
                            'Total Payment',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        )
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Vendor1')),
                            DataCell(Text('80.000.000 VND')),
                            DataCell(Text('7.000.000 VND')),
                            DataCell(Text('11.000.000 VND')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Vendor2')),
                            DataCell(Text('73.000.000 VND')),
                            DataCell(Text('7.000.000 VND')),
                            DataCell(Text('10.650.000 VND')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Vendor3')),
                            DataCell(Text('150.000.000 VND')),
                            DataCell(Text('7.000.000 VND')),
                            DataCell(Text('14.500.000 VND')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Vendor4')),
                            DataCell(Text('120.000.000 VND')),
                            DataCell(Text('7.000.000 VND')),
                            DataCell(Text('13.000.000 VND')),
                          ]
                        ),
                        
                      ],
                    )
                      //)
                    )
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

