import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedDish {
  String dishID;
  String name;
  double price;
  int quantity;
  double revenue;
  OrderedDish({this.name, this.price, this.quantity, this.revenue});
  factory OrderedDish.fromFireBase(DocumentSnapshot doc) {
    Map data = doc.data;
    return OrderedDish(
        name: data['name'],
        price: double.tryParse(data['price']),
        quantity: data['quantity'],
        revenue: double.tryParse(data['revenue'])
        //orders: data['orders'],
        );
  }
}
