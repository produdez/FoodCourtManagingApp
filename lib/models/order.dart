import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';

class OrderedDish {
  String dishID;
  String vendorID;
  String name;
  double price;
  int quantity;
  double revenue;
  int initQuan = 0;
  double initRev = 0;
  OrderedDish(
      {this.name,
      this.price,
      this.quantity,
      this.revenue,
      this.dishID,
      this.vendorID});
}

// this class is not for the whole order of the customer
// instead, it is just the ordered dishes associated with each vendor
class Order {
  String id;
  static String customerID;
  String vendorName;
  String vendorID;
  double totalPrice;
  double initRev = 0;
  List<OrderedDish> detail = [];
  List<OrderedDish> initDetail = [];
  bool inform;
  Order(
      {this.totalPrice,
      this.id,
      this.vendorID,
      this.vendorName,
      this.inform = false});
}
