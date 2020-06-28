import 'dart:ffi';
import 'package:fcfoodcourt/models/dish.dart';

class OrderDetail{
  Dish dish;
  int quant;
}

class Order{
  final String id;
  final String customerID;
  String vendorID;
  double totalPrice;
  List<OrderDetail> detail;
  Order(this.customerID, this.vendorID,
      {this.totalPrice = 0, this.id = ''}) {
  }

  bool isEmpty(){
    if (totalPrice == 0) return true;
    else return false;
  }
}