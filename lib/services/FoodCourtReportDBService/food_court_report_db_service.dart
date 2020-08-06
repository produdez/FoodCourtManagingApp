import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/vendor_report.dart';
import 'package:intl/intl.dart';

class FoodCourtReportDBService{
  static String foodCourtId;
  static String currentMonth;
  static List<MonthlyVendorReport> monthlyReportList = [];
  static DateTime _dateTime = DateTime.now();
  String formattedMonth = DateFormat('MMyyyy').format(_dateTime);
  CollectionReference vendorReportDB = Firestore.instance.collection("vendorReportDB");
  CollectionReference foodCourtReportDB = Firestore.instance.collection("foodCourtReportDB");
  CollectionReference vendorDB = Firestore.instance.collection("vendorDB");
  Future<List<MonthlyVendorReport>> checkAvailableMonthlyReport(String month)async{
    //monthlyReportList.clear();
    List<MonthlyVendorReport> foodCourtReport;
    await _monthlyVendorReportListFromSnapshot(month).then((onValue){
      if(onValue != null)
        foodCourtReport = onValue;
    }).catchError((onError){return null;});
    return foodCourtReport;
  }
  Future<List<MonthlyVendorReport>> _monthlyVendorReportListFromSnapshot(String month) async{
    List<MonthlyVendorReport> foodCourtReport;
    await foodCourtReportDB.getDocuments().then((querySnapshot)async{
      var docs = querySnapshot.documents;
      for(int i = 0; i < docs.length; i++){
        if(docs[i].documentID == "$foodCourtId$month")
        {
          await foodCourtReportDB.document(docs[i].documentID.toString())
          .collection("Vendors").getDocuments().then(_createListofVendorReports);
          foodCourtReport = monthlyReportList;
          break;
        }
      }
    });
    return foodCourtReport;
  }
  _createListofVendorReports(QuerySnapshot querySnapshot){
    var docs = querySnapshot.documents;
    monthlyReportList.clear();
    for(DocumentSnapshot doc in docs){
      monthlyReportList.add(MonthlyVendorReport.fromFireBase(doc));
    }
  } 
  Future createMonthlyReport(String month) async{
    await foodCourtReportDB.document("$foodCourtId$month").setData({
      "month": "${month.substring(0, 2)}/${month.substring(2)}",
      "total proceeds": "0.0",
      "commission": "4%",
      "id": "$foodCourtId$month"
    });
    await vendorReportDB.getDocuments().then((querySnapshot)async{
      String vendorName;
      var docs = querySnapshot.documents;
      for(DocumentSnapshot doc in docs){
        if(doc.data['month'] != null
        && doc.documentID.substring(doc.documentID.length - 6) == month){
          print(doc.data['vendorId']);
          await vendorDB.document("${doc.data['vendorId']}").get().then((snapshot){
            vendorName = snapshot.data['name'];
          });
          await foodCourtReportDB.document("$foodCourtId$month").collection("Vendors")
          .document(doc.data['vendorId'].toString()).setData({
            "name": vendorName, 
            "sale": "${doc.data['sale']}"
          });
        }
      }
    });
  }
  double calculateTotalProceed(List<MonthlyVendorReport> monthlyReports){
    double totalReturn = 0;
    for(int i = 0; i < monthlyReports.length; i++)
      totalReturn += 5000000 + double.tryParse((monthlyReports[i].sale*0.04).toStringAsFixed(2));
    return totalReturn;
  }
}