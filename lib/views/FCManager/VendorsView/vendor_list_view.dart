import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/views/FCManager/VendorsView/vendor_management_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'item_vendor_view.dart';
import 'package:fcfoodcourt/services/search_service.dart';

/* This is the frame list of vendors. It actively listen to vendorDB changes and refresh it's view accordingly
    It also define the function for each button from the vendor elements in the list
 */

class VendorListView extends StatefulWidget {
  @override
  _VendorListViewState createState() => _VendorListViewState();
}

class _VendorListViewState extends State<VendorListView> {
  @override
  Widget build(BuildContext context) {
    final List<Vendor> vendorList = Provider.of<List<Vendor>>(context);
    SearchForVendor.vendorList = vendorList;
    return ListView.builder(
      itemCount: vendorList == null ? 0 : vendorList.length,
      itemBuilder: (context, index) {
        return ItemVendorView(
          vendor: vendorList[index],
          onRemoveSelected: () => VendorManagementViewController.removeVendor(
              context, vendorList[index]),
          onEditSelected: () => VendorManagementViewController.editVendor(
              context, vendorList[index]),
          onCallSelected: () => VendorManagementViewController.callVendor(
              context, vendorList[index]),
        );
      },
    );
  }
}
