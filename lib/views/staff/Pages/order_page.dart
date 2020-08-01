import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/StaffDBService/order_db_service.dart';
import 'package:provider/provider.dart';
import '../Order/order_list.dart';
import '../Order/order.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';

/*
This is the Staff view that holds the frame for the whole Staff
It does holds the add Dish button
 */
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    //OrderDBService.vendorID =
    super.initState();
    //VendorReportDBService().createDailyReport(null);
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
  }

  @override
  Widget build(BuildContext context) {
    //print(OrderDBService.vendorID);
    return StreamProvider<List<Order>>.value(
      value: OrderDBService().orders,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffff8a84),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await AuthenticationService().signOut();
              },
            )
          ],
          title: Text(
            "ORDER LIST",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: OrderList(),
      ),
    );
  }
}
