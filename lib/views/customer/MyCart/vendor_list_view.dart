import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
//import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/customer/MyCart/vendor_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class VendorListView extends StatefulWidget {
  final Function() onChangeConfirm;
  const VendorListView({Key key, this.onChangeConfirm}) : super(key: key);
  @override
  _VendorListViewState createState() => _VendorListViewState();
}

class _VendorListViewState extends State<VendorListView> {
  List<Order> vendorList;

  @override
  void initState() {
    vendorList = CartService.cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vendorList.length,
      itemBuilder: (context, index) {
        return VendorView(
            vendor: vendorList[index], onChangeConfirm: widget.onChangeConfirm);
      },
    );
  }
}
