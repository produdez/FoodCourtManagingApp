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
  OrderedDish(
      {this.name,
      this.price,
      this.quantity,
      this.revenue,
      this.dishID,
      this.vendorID});
  /*
  factory OrderedDish.fromFireBase(DocumentSnapshot doc) {
    Map data = doc.data;
    return OrderedDish(
        name: data['name'],
        price: double.tryParse(data['price']),
        quantity: data['quantity'],
        revenue: double.tryParse(data['revenue']),
        orderID: data['id'],
        vendorID: data['vendorID']);
  }*/
}

// this class is not for the whole order of the customer
// instead, it is just the ordered dishes associated with each vendor
class Order {
  String id;
  static String customerID;
  String vendorName;
  String vendorID;
  double totalPrice;
  List<OrderedDish> detail = [];
  Order({
    this.totalPrice,
    this.id,
    this.vendorID,
    this.vendorName,
  });
  /*factory Order.fromFireBase(DocumentSnapshot doc) {
    Map data = doc.data;

    return Order(
        id: data['id'],
        totalPrice: double.tryParse(data['price']),
        
        vendorID: data['vendorID']
        );
  }*/
}
