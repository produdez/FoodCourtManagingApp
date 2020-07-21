import 'package:flutter/material.dart';
import 'coming_food.dart';
import 'order_data.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Order> _orders = orders;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffff8a84),
        title: Text(
          "VENDOR MENU",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            "Available Dish",
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
