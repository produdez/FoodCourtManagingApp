import 'package:fcfoodcourt/services/FoodCourtReportDBService/food_court_report_db_service.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher(){
    //print("initial");
    Workmanager.executeTask((taskName, inputData)async{
      // VendorReportDBService.vendorId = _getFirstUserId(widget.userData.id);
      switch (taskName) {
        case "auto-generating food court monthly report":
          /*if(_getFirstUserId(inputData['vendorId']) != "uuLXke0DcITuQ10F5eCnEGqSzK62")
            break;*/
          int day = int.parse(DateFormat('d').format(DateTime.now()));
          int month = int.parse(DateFormat('M').format(DateTime.now()));
          int year = int.parse(DateFormat('y').format(DateTime.now()));
          int hour = int.parse(DateFormat('H').format(DateTime.now()));
          //var nextDate = new DateTime(year, month, day + 1);
          var prevMonth = new DateTime(year, month - 1, day);
          //VendorReportDBService.vendorId = await _getFirstUserId(inputData['vendorId']);
          FoodCourtReportDBService.foodCourtId = await _getFirstUserId(inputData['vendorId']);
          print("get in background task for food court");
          print("${FoodCourtReportDBService.foodCourtId}");
          if(day == 1 && hour >= 21)
            await FoodCourtReportDBService().createMonthlyReport(DateFormat('MMyyyy').format(prevMonth));
          break;
        case "auto-generating vendor monthly report":
          //TODO: if first user id is food court id => break
          /*if(_getFirstUserId(inputData['vendorId']) == "uuLXke0DcITuQ10F5eCnEGqSzK62")
            break;*/
          int day = int.parse(DateFormat('d').format(DateTime.now()));
          int month = int.parse(DateFormat('M').format(DateTime.now()));
          int year = int.parse(DateFormat('y').format(DateTime.now()));
          int hour = int.parse(DateFormat('H').format(DateTime.now()));
          var nextDate = new DateTime(year, month, day + 1);
          var prevMonth = new DateTime(year, month - 1, day);
          VendorReportDBService.vendorId = await _getFirstUserId(inputData['databaseID']);
          print("get in background task for vendor");
          print("${VendorReportDBService.vendorId}");
          if(nextDate.day == 1 && hour >= 21)
            await VendorReportDBService().createMonthlyReport(DateFormat('MMyyyy').format(DateTime.now()));
          break;
      }
      return Future.value(true);
    });
  }
_getFirstUserId(String userId) async{
    String firstUserId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('firstUserId') == null)
      prefs.setString('firstUserId', userId);
    firstUserId = prefs.getString('firstUserId');
    return firstUserId;
  }