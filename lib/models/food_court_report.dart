import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/vendor.dart';

class MonthlyFoodCourtReport{
  String id;
  String month;
  List<Vendor> vendor = [];
  double rent;
  double commission;
  double totalRent;
  MonthlyFoodCourtReport({this.id, this.month, this.totalRent});
}