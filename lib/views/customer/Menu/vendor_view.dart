//import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_list_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';

import '../../../models/vendor.dart';
import 'home.dart';

/*
This is the vendor element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class VendorView extends StatelessWidget {
  final Vendor vendor;
  final Function(String, String) onVendorSelected;
  const VendorView({
    Key key,
    this.vendor,
    this.onVendorSelected,
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
          onVendorSelected(
              vendor.id, vendor.name); //Pass vendor name for cart work
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
                InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                    child: GFAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: showImage(context)),
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Text(
                          vendor.name,
                          style: TextStyle(
                              color: Color(0xbb000000),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Row(children: <Widget>[
                      Container(
                          child: Text(
                        'Phone: ',
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      )),
                      Container(
                          child: Text(
                        vendor.phone,
                        style: TextStyle(
                            color: Colors.green[500],
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600),
                      )),
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

  Widget showImage(BuildContext context) {
    if (vendor.hasImage == false) {
      return Container(
          height: MediaQuery.of(context).size.height / 1.25,
          width: MediaQuery.of(context).size.width / 1.25,
          child: Image.asset(
            "assets/vendor.png",
            fit: BoxFit.fill,
          ));
    } else if (vendor.imageURL == null) {
      return CircularProgressIndicator();
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          vendor.imageURL,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
