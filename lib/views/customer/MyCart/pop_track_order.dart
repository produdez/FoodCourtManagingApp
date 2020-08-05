import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/services/order_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_list.dart';

/*
A form that shows confirmation.
The function createConfirmationView returns a Future<bool>
which tells if user confirmed or not
 */
class TrackingOrderView extends StatefulWidget {
  final Function() onConfirmPress;
  const TrackingOrderView({Key key, this.onConfirmPress}) : super(key: key);
  @override
  _TrackingOrderState createState() => _TrackingOrderState();
}

class _TrackingOrderState extends State<TrackingOrderView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Order>>.value(
        value: OrderDBService().orders,
        child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(40),
                  //border: Border.all(color: Color(0xfff85f6a), width: 4)
                ),
                height: 500,
                width: 350,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 12, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Please track your orders",
                            style: TextStyle(
                              color: Color(0xffff6624),
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: OrderListView(backButton: () {
                        widget.onConfirmPress();
                        Navigator.of(context).pop(false);
                      })),
                      SizedBox(width: 12, height: 20),
                    ]),
              ),
            )));
  }
}

Future<bool> createTrackOrderView(
    BuildContext context, Function onConfirmPress) {
  return showDialog(
      context: context,
      builder: (context) {
        return TrackingOrderView(onConfirmPress: onConfirmPress);
      });
}
