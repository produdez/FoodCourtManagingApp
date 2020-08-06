//import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_list_view.dart';
import 'package:fcfoodcourt/views/customer/MyCart/pop_ordered_dishes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';

/*
This is the vendor element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class VendorView extends StatelessWidget {
  final Order vendor;
  final Function() onChangeConfirm;

  const VendorView({
    Key key,
    this.vendor,
    this.onChangeConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 400,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          createOrderedDishesPopUp(context, vendor.vendorID, onChangeConfirm)
              .then((onValue) {});
        },
        child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.white,
            elevation: 0,
            borderRadius: BorderRadius.circular(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          vendor.vendorName,
                          style: TextStyle(
                              color: Color(0xbb000000),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: Row(children: <Widget>[
                          Text(
                            'Total: ',
                            style: TextStyle(
                                fontSize: 8.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            vendor.totalPrice.toString(),
                            style: TextStyle(
                                color: Colors.green[500],
                                fontSize: 8.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ]))
                    //The price is displayed dynamically by view logic
                    // ViewLogic.displayPrice(context, vendor)
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
