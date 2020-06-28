
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/FCManager/VendorsView/popUpForms/edit_vendor_view.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'item_vendor_view.dart';

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

    return ListView.builder(
      itemCount: vendorList == null ? 0 : vendorList.length,
      itemBuilder: (context, index) {
        return ItemVendorView(
          vendor: vendorList[index],
          onRemoveSelected: () {
            //Remove chosen, ask user for confirmation and remove in DB if confirmed
            createConfirmationView(context).then((onValue) {
              if (onValue == true) {
                VendorDBService().removeVendor(vendorList[index]);
              }
            });
          },
          onEditSelected: () {
            //Edit chosen, show edit form and process returned information
            //The return value is Vendor with name and price (no realPrice,...)
            createPopUpEditVendor(context, vendorList[index]).then((onValue) {
              if (onValue != null) {
                VendorDBService().editVendor(vendorList[index], onValue);
              }
            });
          },
          onCallSelected: () {
            VendorDBService().callVendor(vendorList[index]);
          },
        );
      },
    );
  }
}
