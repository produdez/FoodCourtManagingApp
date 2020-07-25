

import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/popUpForms/edit_staff_view.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/popUpForms/new_staff_view.dart';
import 'package:flutter/cupertino.dart';

class ManageStaffViewController {
  static void addStaff(BuildContext context){
    //On newDish chosen, show newDish popUp and process information
    //The return value is a Dish with name, price (every other fields are defaulted)
    createPopUpNewStaff(context).then((onValue) {
      if (onValue != null) {
        StaffDBService().addStaff(onValue);
      }
    }); //This request the pop-up new vendor form
  }
  static void removeStaff(BuildContext context, Staff staff){
    //Remove chosen, ask user for confirmation and remove in DB if confirmed
    createConfirmationView(context).then((onValue) {
      if (onValue == true) {
        StaffDBService().removeStaff(staff);
      }
    });
  }
  static void editStaff(BuildContext context, Staff staff){
    //Edit chosen, show edit form and process returned information
    //The return value is Dish with name and price (no realPrice,...)
    createPopUpEditStaff(context, staff).then((onValue) {
      if (onValue != null) {
        StaffDBService().editStaff(staff, onValue);
      }
    });
  }
  static void callStaff(BuildContext context, Staff staff){
    //Discount chosen, show discount form and process returned information
    //The return value is Dish with discounted price and percentage (no name,...)
    StaffDBService().callStaff(staff);
  }
}