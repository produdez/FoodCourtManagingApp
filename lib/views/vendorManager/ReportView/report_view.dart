import 'package:flutter/material.dart';
import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';

class ReportView extends StatefulWidget{
  final String date;
  const ReportView(this.date);
  @override 
  _ReportViewState createState() => _ReportViewState(this.date);
}

class _ReportViewState extends State<ReportView> with SingleTickerProviderStateMixin{
  TabController _tabController;
  String date;
  _ReportViewState(this.date);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false, // address bottom overflow error
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
        ),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 4, color: Colors.black),
          )),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 25,
            backgroundColor: Color(0xffff8a84),
            selectedFontSize: 20,
            unselectedFontSize: 20,
            currentIndex: 2,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant),
                  title: Text("Menu"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                title: Text("Staff"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                title: Text(
                  "Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
              ),
            ],
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
                        /*decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 4),
                        ),*/
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
                      child: DataTable(
                      columns: const <DataColumn>[
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
                        )
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Pho')),
                            DataCell(Text('4')),
                            DataCell(Text('30k')),
                            DataCell(Text('120k')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Hu Tieu')),
                            DataCell(Text('4')),
                            DataCell(Text('25k')),
                            DataCell(Text('100k')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Bun Bo Hue')),
                            DataCell(Text('4')),
                            DataCell(Text('20k')),
                            DataCell(Text('80k')),
                          ]
                        ),
                        
                      ],
                    )
                    )
                  ],
                ),
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
                        /*decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 4),
                        ),*/
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
                        )
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Pho')),
                            DataCell(Text('4')),
                            DataCell(Text('30k')),
                            DataCell(Text('120k')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Hu Tieu')),
                            DataCell(Text('4')),
                            DataCell(Text('25k')),
                            DataCell(Text('100k')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Bun Bo Hue')),
                            DataCell(Text('4')),
                            DataCell(Text('20k')),
                            DataCell(Text('80k')),
                          ]
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Bun Bo Hue')),
                            DataCell(Text('4')),
                            DataCell(Text('20k')),
                            DataCell(Text('80k')),
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