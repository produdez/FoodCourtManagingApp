import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';

class OrderedDish {
  String dishID;
  String name;
  double price;
  int quantity;
  double revenue;
  OrderedDish({this.name, this.quantity, this.revenue});
  factory OrderedDish.fromFireBase(DocumentSnapshot doc) {
    return OrderedDish(
      name: doc.data['name'],
      quantity: doc.data['quantity'],
    );
  }
}

// this class is not for the whole order of the customer
// instead, it is just the ordered dishes associated with each vendor
class Order {
  final String id;
  final String customerID;
  String vendorID;
  double totalPrice;
  List<OrderedDish> detail = [];
  Order({
    this.customerID,
    this.totalPrice = 0,
    this.id = '',
    this.vendorID,
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
