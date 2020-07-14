import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DailyVendorReport {
  String id; // id is from database
  String vendorId;
  double sale;
  String date;
  List<Order> orders;

  /*bool hasImage;
  File imageFile;*/
  //normal constructor
  //DailyVendorReport(this.id, this.vendorId, this.sale, this.date);
  DailyVendorReport({this.date, this.sale});

  factory DailyVendorReport.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return DailyVendorReport(
      //id: data['id'],
      //vendorId: data['vendorId'],
      sale: double.tryParse(data['sale']),
      date: data['date'],
      //orders: data['orders'],
    );
  }
}

class Order{
  String name;
  double price;
  int quantity;
  double revenue;
  Order({this.name, this.price, this.quantity, this.revenue});
  factory Order.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return Order(
      name: data['name'],
      price: double.tryParse(data['price']),
      quantity: data['quantity'],
      revenue: double.tryParse(data['revenue'])
      //orders: data['orders'],
    );
  }
}
class MonthlyVendorReport{
  double sale;
  String month;
  //String name;
  String id;
  MonthlyVendorReport({this.sale});
  factory MonthlyVendorReport.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return MonthlyVendorReport(
      sale: double.tryParse(data['sale']),
      //month: data['month']
    );
  }
}
class Month{
  String vendorId;
  String month;
  Month(this.vendorId, this.month);
}
