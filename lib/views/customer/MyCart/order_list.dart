import 'package:fcfoodcourt/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_view.dart';

class OrderListView extends StatefulWidget {
  final Function() backButton;

  const OrderListView({Key key, this.backButton}) : super(key: key);
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderListView> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    if (orders.length == 0)
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xfff85f6a),
                  child: Text(
                    'BACK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: widget.backButton,
                )
              ],
            )
          ]);
    else
      return ListView.builder(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
        ),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderView(order: orders[index]);
        },
      );
  }
}
