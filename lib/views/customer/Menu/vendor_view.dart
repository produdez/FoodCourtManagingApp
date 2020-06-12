//import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';

import '../../../models/vendor.dart';

/*
This is the vendor element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class VendorView extends StatelessWidget {
  final Vendor vendor;

  const VendorView(
      {Key key,
      this.vendor,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 0,
          borderRadius: BorderRadius.circular(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: "ID: ${vendor.id}",
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      )),
                  child: GFAvatar(
                    backgroundImage: AssetImage(
                        //TODO: Find a way to store cloud image and load that also
                        //TODO: And then implement image choosing for vendor profile when newvendor or editvendor
                        'assets/${vendor.id}.jpg'),
                    shape: GFAvatarShape.square,
                    radius: 25,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    vendor.name,
                    style: TextStyle(
                        color: Color(0xffffa834),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )),

                  //The price is displayed dynamically by view logic
                 // ViewLogic.displayPrice(context, vendor),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
