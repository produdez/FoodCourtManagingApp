import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/orderedDish.dart';
import 'package:fcfoodcourt/views/staff/ordered_dish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_db_service.dart';
import 'order.dart';

class OrderDetail extends StatefulWidget {
  //final String orderID;
  final List<OrderedDish> orderedList;
  const OrderDetail(this.orderedList);
  @override
  _OrderDetailState createState() => _OrderDetailState(this.orderedList);
}

class _OrderDetailState extends State<OrderDetail> {
  List<OrderedDish> orderedList;
  _OrderDetailState(this.orderedList);
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
      ),
      body: OrderedDishList(orderedList),
    );
  }
}
