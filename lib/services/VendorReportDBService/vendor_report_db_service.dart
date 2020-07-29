//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/orderedDish.dart';
import 'package:fcfoodcourt/models/vendor_report.dart';
import 'package:fcfoodcourt/views/staff/order.dart';
import 'package:intl/intl.dart';

class VendorReportDBService {
  static String vendorId;
  static List<OrderedDish> orderList = [];
  static List<DailyVendorReport> dailyReportList = [];
  static List<Month> currentMonth = [];
  static DateTime _dateTime = DateTime.now();
  String formattedDate = DateFormat('ddMMyyyy').format(_dateTime);
  CollectionReference vendorReportDB =
      Firestore.instance.collection("vendorReportDB");
  Future<List<OrderedDish>> checkAvailableDailyReport(String time) async {
    List<OrderedDish> dailyReport;
    await _orderListFromSnapshot(time).then((onValue) {
      if (onValue != null) dailyReport = onValue;
    }).catchError((onError) {
      return null;
    });
    return dailyReport;
  }

  Future<List<OrderedDish>> _orderListFromSnapshot(String time) async {
    List<OrderedDish> dailyReport;
    int i;
    await vendorReportDB.getDocuments().then((snapshot) async {
      for (i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].documentID == '$vendorId$time') {
          await vendorReportDB
              .document(snapshot.documents[i].documentID.toString())
              .collection("Orders")
              .getDocuments()
              .then(_createListofOrders);
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
    for (DocumentSnapshot doc in docs)
      orderList.add(OrderedDish.fromFireBase(doc));
  }

  //check and return an available monthly report
  Future<List<DailyVendorReport>> checkAvailableMonthlyReport(
      String time) async {
    List<DailyVendorReport> monthlyReport;
    await _dailyReportListFromSnapshot(time).then((onValue) {
      if (onValue != null) monthlyReport = onValue;
    }).catchError((onError) {
      return null;
    });
    return monthlyReport;
  }

  Future<List<DailyVendorReport>> _dailyReportListFromSnapshot(
      String time) async {
    List<DailyVendorReport> monthlyReport;
    await vendorReportDB.getDocuments().then((snapshot) async {
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].documentID == '$vendorId$time') {
          await vendorReportDB
              .document(snapshot.documents[i].documentID.toString())
              .collection("Daily Reports")
              .getDocuments()
              .then(_createListofDailyReports);
          monthlyReport = dailyReportList;
          break;
        }
      }
    });
    return monthlyReport;
  }

  _createListofDailyReports(QuerySnapshot querySnapshot) {
    var docs = querySnapshot.documents;
    dailyReportList.clear();
    for (DocumentSnapshot doc in docs)
      dailyReportList.add(DailyVendorReport.fromFireBase(doc));
    DailyVendorReport.previousDateSale = 0.0;
  }

  //Update Daily Vendor Report with new list of orders
  Future updateDailyReport(List<OrderedDish> newOrders) async {
    int found = 0;
    //DateTime date = DateTime.now();
    //String formattedDate = DateFormat('ddMMyyyy').format(_dateTime);
    String reportId = "$vendorId$formattedDate";
    // update the total sale
    await vendorReportDB.document(reportId).get().then((documentSnapshot) {
      vendorReportDB.document(reportId).updateData({
        "sale":
            "${double.tryParse(documentSnapshot.data['sale']) + calculateTotalSale(newOrders)}"
      });
    });
    // update the Orders
    return await vendorReportDB
        .document(reportId)
        .collection("Orders")
        .getDocuments()
        .then((querySnapshot) async {
      var docs = querySnapshot.documents;
      for (int i = 0; i < newOrders.length; i++) {
        for (DocumentSnapshot doc in docs) {
          // If the order already exists in the firebase => update the revenue and quantity
          if (newOrders[i].name == doc.documentID) {
            await vendorReportDB
                .document(reportId)
                .collection("Orders")
                .document(doc.documentID)
                .get()
                .then((_ordersSnapshot) async {
              double updatedRevenue =
                  double.tryParse(_ordersSnapshot.data['revenue']) +
                      newOrders[i].revenue;
              await vendorReportDB
                  .document(reportId)
                  .collection("Orders")
                  .document(doc.documentID)
                  .updateData({
                //"name": newOrders[i].name,
                //"price": "${newOrders[i].price}",
                "quantity":
                    _ordersSnapshot.data['quantity'] + newOrders[i].quantity,
                "revenue": "$updatedRevenue"
              });
            });
            found = 1;
            break;
          }
          found = 0;
        }
        // If the order does not exist in the fire base => create new one
        if (found == 0) {
          vendorReportDB
              .document(reportId)
              .collection("Orders")
              .document(newOrders[i].name)
              .setData({
            "name": newOrders[i].name,
            "price": "${newOrders[i].price}",
            "quantity": newOrders[i].quantity,
            "revenue": "${newOrders[i].revenue}",
          });
        }
      }
    });
  }

  //Create new Daily Vendor Report
  Future createDailyReport(List<OrderedDish> newOrders) async {
    //DateTime date = DateTime.now();
    double sale = newOrders == null ? 0.0 : calculateTotalSale(newOrders);
    //String formattedDate = DateFormat('ddMMyyyy').format(date);
    await vendorReportDB.document("$vendorId$formattedDate").setData({
      "id": "$vendorId$formattedDate",
      "vendorId": vendorId,
      "date": DateFormat('dd/MM/yyyy').format(_dateTime),
      "sale": "$sale"
    });
    if (newOrders != null) {
      for (int i = 0; i < newOrders.length; i++) {
        await vendorReportDB
            .document("$vendorId$formattedDate")
            .collection("Orders")
            .document(newOrders[i].name)
            .setData({
          "name": newOrders[i].name,
          "price": "${newOrders[i].price}",
          "quantity": newOrders[i].quantity,
          "revenue": "${newOrders[i].revenue}",
        });
      }
    }
  }

  // create monthly report
  Future createMonthlyReport(String month) async {
    double sale = 0;
    await vendorReportDB.document("$vendorId$month").setData({
      "month": "${month.substring(0, 2)}/${month.substring(2)}",
      "sale": "0.0",
      "id": "$vendorId$month",
      "vendorId": "$vendorId"
    });
    await vendorReportDB.getDocuments().then((querySnapshot) async {
      var docs = querySnapshot.documents;
      for (DocumentSnapshot doc in docs) {
        if (doc.data["vendorId"] == vendorId &&
            doc.documentID != "$vendorId$month" &&
            doc.documentID.substring(doc.documentID.length - 6) == month) {
          sale += double.tryParse(doc.data['sale']);
          await vendorReportDB
              .document("$vendorId$month")
              .collection("Daily Reports")
              .document(doc.documentID.substring(doc.documentID.length - 8))
              .setData(
                  {"date": "${doc.data['date']}", "sale": doc.data['sale']});
        }
      }
    });
    await vendorReportDB
        .document("$vendorId$month")
        .updateData({"sale": "$sale"});
  }

  //calculate the total sale
  double calculateTotalSale(List<OrderedDish> orders) {
    double totalSale = 0;
    for (int i = 0; i < orders.length; i++) totalSale += (orders[i].revenue);
    return totalSale;
  }

  double calculateTotalReturn(List<DailyVendorReport> dailyReports) {
    double totalReturn = 0;
    for (int i = 0; i < dailyReports.length; i++)
      totalReturn += dailyReports[i].sale;
    return totalReturn;
  }
}
