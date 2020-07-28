import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Dish {
  String id; // id is from database
  String name;
  double
      originPrice; //the original price before discount (not price) used in calculation
  double discountPercentage; //discount
  double realPrice; //real price due to discount
  bool isOutOfOrder; //TODO: add to db
  String vendorID;
  bool hasImage;
  File imageFile;
  //normal constructor
  Dish(this.name, this.originPrice,
      {this.discountPercentage = 0,
      this.realPrice,
      this.id = "",
      this.vendorID = "",
      this.imageFile,
      this.hasImage = false,
      this.isOutOfOrder = false}) {
    if (this.realPrice == null) this.realPrice = this.originPrice;
  }

  //copy constructor
  Dish.clone(Dish dish) {
    this.name = dish.name;
    this.originPrice = dish.originPrice;
    this.id = dish.id;
    this.discountPercentage = dish.discountPercentage;
    this.realPrice = dish.realPrice;
    this.hasImage = dish.hasImage;
    this.isOutOfOrder = dish.isOutOfOrder;
    //do not copy imageFile
  }
  @override
  String toString() => 'Dish { name: $name }';

  factory Dish.fromFireBase(DocumentSnapshot doc) {
    Map data = doc.data;
    return Dish(
      data['name'],
      data['originPrice'],
      discountPercentage: data['discountPercentage'],
      realPrice: data['realPrice'],
      id: data['id'],
      vendorID: data['vendorID'],
      isOutOfOrder: data['isOutOfOrder'],
    );
  }
}
