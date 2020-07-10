import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DailyVendorReport {
  String id; // id is from database
  String vendorId;
  String sale;
  String date;
  List<Order> orders;

  /*bool hasImage;
  File imageFile;*/
  //normal constructor
  //DailyVendorReport(this.id, this.vendorId, this.sale, this.date);
  DailyVendorReport({this.date, this.sale, this.id, this.vendorId});

  factory DailyVendorReport.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return DailyVendorReport(
      //id: data['id'],
      //vendorId: data['vendorId'],
      sale: data['sale'],
      date: data['date'],
      //orders: data['orders'],
    );
  }
}
class Order{
  String name;
  String price;
  String quantity;
  String revenue;
  Order({this.name, this.price, this.quantity, this.revenue});
  factory Order.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return Order(
      name: data['name'],
      price: data['price'],
      quantity: data['quantity'],
      revenue: data['revenue']
      //orders: data['orders'],
    );
  }
}
