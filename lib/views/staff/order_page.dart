import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'order_db_service.dart';
import 'package:provider/provider.dart';
import 'order_list.dart';
import 'order.dart';

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
  Widget build(BuildContext context) {
    return StreamProvider<List<Order>>.value(
      value: OrderDBService().orders,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "ORDER LIST",
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
        body: OrderList(),
      ),
    );
  }
}
