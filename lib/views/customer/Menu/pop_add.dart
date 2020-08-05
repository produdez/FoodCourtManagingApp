import 'package:fcfoodcourt/services/cart_service.dart';
import 'package:fcfoodcourt/services/order_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MyCart/pop_track_order.dart';

/*
A form that shows confirmation.
The function createConfirmationView returns a Future<bool>
which tells if user confirmed or not
 */
class AddedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(40),
            //border: Border.all(color: Color(0xfff85f6a), width: 4)
          ),
          height: 150,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 12),
                  Text(
                    "Added to cart",
                    style: TextStyle(
                      color: Color(0xffff6624),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.white,
                    child: Text(
                      "BACK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> createAddedView(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AddedView();
      });
}
