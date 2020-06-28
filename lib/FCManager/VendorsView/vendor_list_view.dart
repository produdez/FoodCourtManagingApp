
import 'package:fcfoodcourt/FCManager/VendorsView/item_vendor_view.dart';
import 'package:fcfoodcourt/FCManager/VendorsView/popUpForms/edit_vendor_view.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/discount_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/edit_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
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
            //The return value is Dish with name and price (no realPrice,...)
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
