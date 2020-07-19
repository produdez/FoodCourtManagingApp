import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coming_order.dart';
import 'order_data.dart';

/*
This is the Staff view that holds the frame for the whole Staff
It does holds the add Dish button
 */
class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orders = orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            "New Coming Orders",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Color(0xffff8a84),
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            children: _orders.map(_buildOrderItems).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(Order order) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: ComingOrder(
        id: order.id,
        phoneNumber: order.phoneNumber,
        imagePath: order.imagePath,
        totalPrice: order.totalPrice,
      ),
    );
  }
}
