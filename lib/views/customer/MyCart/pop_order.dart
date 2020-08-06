import 'package:fcfoodcourt/services/cart_service.dart';
import 'package:fcfoodcourt/services/order_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pop_track_order.dart';

/*
A form that shows confirmation.
The function createConfirmationView returns a Future<bool>
which tells if user confirmed or not
 */
class ConfirmationView extends StatelessWidget {
  final Function() onConfirmPress;
  const ConfirmationView({Key key, this.onConfirmPress}) : super(key: key);
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
          height: 250,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 12),
                  Text(
                    (CartService.cart.length != 0)
                        ? "Do you want to order?"
                        : "Failed to place order",
                    style: TextStyle(
                      color: Color(0xffff6624),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
              Text(
                (CartService.cart.length != 0)
                    ? "  Please confirm!"
                    : "Your cart is empty!",
                style: TextStyle(
                  color: Color(0xfff85f6a),
                  fontSize: 25,
                ),
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
                      (CartService.cart.length != 0) ? 'CANCEL' : "BACK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  (CartService.cart.length != 0)
                      ? FlatButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Color(0xfff85f6a),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => {
                            OrderDBService().createOrder(),

                            // CartService.initCart.clear(),
                            // CartService.initTotal = 0,
                            Navigator.of(context).pop(true),
                            createTrackOrderView(context, onConfirmPress)
                                .then((onValue) {})
                          },
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> createConfirmationView(
    BuildContext context, Function() onConfirmPress) {
  return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationView(onConfirmPress: onConfirmPress);
      });
}
