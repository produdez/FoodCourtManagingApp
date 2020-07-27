

import 'package:cloud_firestore/cloud_firestore.dart';

class DailyVendorReport {
  static double previousDateSale = 0;
  String id; // id is from database
  String vendorId;
  double sale;
  String date;
  List<Order> orders;
  double totalSaleChange;

  /*bool hasImage;
  File imageFile;*/
  //normal constructor
  //DailyVendorReport(this.id, this.vendorId, this.sale, this.date);
  DailyVendorReport({this.date, this.sale, this.totalSaleChange});

  factory DailyVendorReport.fromFireBase(DocumentSnapshot doc){
    double saleChange = 0.0;
    Map data = doc.data;
    if (previousDateSale != 0){
      saleChange = (1/(previousDateSale / double.tryParse(data['sale'])) - 1)*100;
      saleChange = double.tryParse(saleChange.toStringAsFixed(2));
    }
    previousDateSale = double.tryParse(data['sale']);
    return DailyVendorReport(
      //id: data['id'],
      //vendorId: data['vendorId'],
      sale: double.tryParse(data['sale']),
      date: data['date'],
      totalSaleChange: saleChange
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
  String name;
  String id;
  MonthlyVendorReport({this.sale, this.name});
  factory MonthlyVendorReport.fromFireBase(DocumentSnapshot doc){
    Map data = doc.data;
    return MonthlyVendorReport(
      sale: double.tryParse(data['sale']),
      name: data['name']
    );
  }
}
class Month{
  String vendorId;
  String month;
  Month(this.vendorId, this.month);
}
