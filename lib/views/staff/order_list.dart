import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order.dart';
import 'order_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];

    return ListView.builder(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderTile(order: orders[index]);
      },
    );
  }
}
