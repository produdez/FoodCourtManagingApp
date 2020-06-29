import 'dart:ffi';
import 'package:fcfoodcourt/models/dish.dart';

class OrderDetail{
  final String dishID;
  int quant;

  OrderDetail(this.dishID, this.quant);
}

class Order{
  final String id;
  //final String customerID;
  //String vendorID;
  double totalPrice;
  List<OrderDetail> detail;
  Order(
      {this.totalPrice = 0, this.id = ''}) {
  }

  bool isEmpty(){
    if (totalPrice == 0) return true;
    else return false;
  }
}