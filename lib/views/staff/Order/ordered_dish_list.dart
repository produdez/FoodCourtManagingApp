import 'package:fcfoodcourt/models/orderedDish.dart';
import 'package:fcfoodcourt/services/StaffDBService/order_db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order.dart';
import 'ordered_dish_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedDishList extends StatefulWidget {
  final List<OrderedDish> orderedList;
  OrderedDishList(this.orderedList);
  @override
  _OrderedDishListState createState() =>
      _OrderedDishListState(this.orderedList);
}

class _OrderedDishListState extends State<OrderedDishList> {
  List<OrderedDish> orderedList;
  _OrderedDishListState(this.orderedList);
  @override
  Widget build(BuildContext context) {
    final ordereddishes = orderedList;
    return ListView.builder(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      itemCount: ordereddishes.length,
      itemBuilder: (context, index) {
        return OrderedDishTile(orderedDish: ordereddishes[index]);
      },
    );
  }
}
