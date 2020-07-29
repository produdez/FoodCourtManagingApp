
/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/views/sharedView_Vendor_FC/StaffListView/manage_staff_view_controller.dart';
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
          onRemoveSelected: () => ManageStaffViewController.removeStaff(context, staffList[index]),
          onEditSelected: () => ManageStaffViewController.editStaff(context, staffList[index]),
          onCallSelected: () => ManageStaffViewController.callStaff(context, staffList[index]),
        );
      },
    );
  }
}
