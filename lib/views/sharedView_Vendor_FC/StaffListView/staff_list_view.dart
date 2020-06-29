
/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/popUpForms/edit_staff_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'item_staff_view.dart';

class StaffListView extends StatefulWidget {
  @override
  _StaffListViewState createState() => _StaffListViewState();
}

class _StaffListViewState extends State<StaffListView> {
  @override
  Widget build(BuildContext context) {
    final List<Staff> staffList = Provider.of<List<Staff>>(context);

    return ListView.builder(
      itemCount: staffList == null ? 0 : staffList.length,
      itemBuilder: (context, index) {
        return ItemStaffView(
          staff: staffList[index],
          onRemoveSelected: () {
            //Remove chosen, ask user for confirmation and remove in DB if confirmed
            createConfirmationView(context).then((onValue) {
              if (onValue == true) {
                StaffDBService().removeStaff(staffList[index]);
              }
            });
          },
          onEditSelected: () {
            //Edit chosen, show edit form and process returned information
            //The return value is Dish with name and price (no realPrice,...)
            createPopUpEditStaff(context, staffList[index]).then((onValue) {
              if (onValue != null) {
                StaffDBService().editStaff(staffList[index], onValue);
              }
            });
          },
          onCallSelected: () {
            //Discount chosen, show discount form and process returned information
            //The return value is Dish with discounted price and percentage (no name,...)
                StaffDBService().callStaff(staffList[index]);
          },
        );
      },
    );
  }
}
