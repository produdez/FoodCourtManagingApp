
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/views/FCManager/VendorsView/popUpForms/edit_vendor_view.dart';
import 'package:fcfoodcourt/views/FCManager/VendorsView/popUpForms/new_vendor_view.dart';
import 'package:flutter/cupertino.dart';

class VendorManagementViewController{
  static void addVendor(BuildContext context){
    //On newVendor chosen, show newVendor popUp and process information
    //The return value is a Vendor with name, price (every other fields are defaulted)
    createPopUpNewVendor(context).then((onValue) {
      if (onValue != null) {
        VendorDBService().addVendor(onValue);
      }
    }); //This request the pop-up new vendor form
  }

  static void removeVendor(BuildContext context, Vendor vendor){
    //Remove chosen, ask user for confirmation and remove in DB if confirmed
    createConfirmationView(context).then((onValue) {
      if (onValue == true) {
        VendorDBService().removeVendor(vendor);
      }
    });
  }

  static void editVendor(BuildContext context, Vendor vendor){
    //Edit chosen, show edit form and process returned information
    //The return value is Vendor with name and price (no realPrice,...)
    createPopUpEditVendor(context, vendor).then((onValue) {
      if (onValue != null) {
        VendorDBService().editVendor(vendor, onValue);
      }
    });
  }

  static void callVendor(BuildContext context, Vendor vendor){
    VendorDBService().callVendor(vendor);
  }
}