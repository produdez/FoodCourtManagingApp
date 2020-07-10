//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/DailyVendorReport.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/report_view.dart';

class VendorReportDBService{
  /*final CollectionReference vendorReportDB = Firestore.instance.collection("vendorReportDB");
  DailyVendorReport _dailyVendorReportFromSnapshot(DocumentSnapshot snapshot){
    return DailyVendorReport(
      id: snapshot.data['id'],
      vendorId: snapshot.data['vendorId'],
      sale: snapshot.data['sale'],
      date: snapshot.data['date'],
    );
  }
  Future<DailyVendorReport> checkAvailable(String time, int reportType) async {
    //DocumentReference _vendorReportRef = vendorReportDB.document(time)
    DailyVendorReport report;
    await vendorReportDB.document(time).get().then((onValue){
      report = _dailyVendorReportFromSnapshot(onValue);
    });
    return report;
  }*/
  static List<Order> orderList = [];
  static List<DailyVendorReport> dailyReportList = [];
  static int orderNum = 0;
  //final CollectionReference orderDB = Firestore.instance.collection("vendorReportDB");
  Future<List<Order>> checkAvailableDailyReport(String time, String vendorId) async {
    List<Order> dailyReport;
    await _orderListFromSnapshot(time, vendorId).then((onValue){
      if(onValue != null)
      dailyReport = onValue;
    }).catchError((onError){return null;});
    return dailyReport;
  }
  Future<List<Order>> _orderListFromSnapshot(String time, String vendorId) async{
    List<Order> dailyReport;
    int i;
    await Firestore.instance.collection("vendorReportDB").getDocuments().then((snapshot) async{
      for(i = 0; i < snapshot.documents.length; i++){
        if(snapshot.documents[i].documentID == time && snapshot.documents[i].data['vendorId'] == vendorId)
        {
          await Firestore.instance.collection("vendorReportDB").document(snapshot.documents[i].documentID.toString())
          .collection("Orders").getDocuments().then(_createListofOrders);
          dailyReport = orderList;
          break;
        }
      }
    });
    return dailyReport;
  }
  _createListofOrders(QuerySnapshot querySnapshot) {
    var docs = querySnapshot.documents;
    orderList.clear();
    for(DocumentSnapshot doc in docs)
      orderList.add(Order.fromFireBase(doc));
  }

  Future<List<DailyVendorReport>> checkAvailableMonthlyReport(String time,String vendorId) async{
    List<DailyVendorReport> monthlyReport;
    await _dailyReportListFromSnapshot(time, vendorId).then((onValue){
      if(onValue != null)
      monthlyReport = onValue;
    }).catchError((onError){return null;});
    return monthlyReport;
  }

  Future<List<DailyVendorReport>> _dailyReportListFromSnapshot(String time, String vendorId) async{
    List<DailyVendorReport> monthlyReport;
    await Firestore.instance.collection("vendorReportDB").getDocuments().then((snapshot) async{
      for(int i = 0; i < snapshot.documents.length; i++){
        if(snapshot.documents[i].documentID == '$vendorId$time')
        {
          await Firestore.instance.collection("vendorReportDB").document(snapshot.documents[i].documentID.toString())
          .collection("Daily Reports").getDocuments().then(_createListofDailyReports);
          monthlyReport = dailyReportList;
          break;
        }
      }
    });
    return monthlyReport;
  }

  _createListofDailyReports(QuerySnapshot querySnapshot){
    var docs = querySnapshot.documents;
    dailyReportList.clear();
    for(DocumentSnapshot doc in docs)
      dailyReportList.add(DailyVendorReport.fromFireBase(doc));
  }
}