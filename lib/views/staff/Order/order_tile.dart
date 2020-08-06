import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/services/StaffDBService/order_db_service.dart';
import 'package:fcfoodcourt/views/staff/Order/ordered_dish_detail.dart';
import 'package:flutter/material.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';

import 'order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 400.0,
            //child: Image.asset('assets/lunch.jpeg', fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 80.0,
              width: 400.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
          Positioned(
            left: 5.0,
            bottom: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.customerID,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                'Finish',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xffff8a84),
                              onPressed: () {
                                finishOrder(context);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xffff8a84),
                              onPressed: () async {
                                print(order.id);
                                await OrderDBService()
                                    .viewOrderedDish(order.id)
                                    .then((onValue) {
                                  print(onValue.length);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetail(onValue)));
                                });
                              },
                            ),
                            FlatButton(
                                child: Text(
                                  'Inform',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Color(0xffff8a84),
                                onPressed: () {
                                  informCustomer(context);
                                }),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 10.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  order.totalPrice.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Total Price",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  finishOrder(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.red[300],
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Color(0xffff8a84),
                onPressed: () async {
                  await OrderDBService()
                      .viewOrderedDish(order.id)
                      .then((value) async {
                    await VendorReportDBService().updateDailyReport(value);
                  });
                  Navigator.pop(context);
                  Firestore.instance
                      .collection('orderDB')
                      .document(order.id)
                      .delete();
                },
                child: Text(
                  'Finish',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
            title: Text('Finish order?'),
          );
        });
  }

  Future<void> informCustomer(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customer Informed'),
          content: SingleChildScrollView(
              // child: ListBody(
              //   children: <Widget>[
              //     Text('This is a demo alert dialog.'),
              //     Text('Would you like to approve of this message?'),
              //   ],
              // ),
              ),
          actions: <Widget>[
            FlatButton(
              color: Color(0xffff8a84),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await Firestore.instance
                    .collection('orderDB')
                    .document(order.id)
                    .updateData({'inform': true});
              },
            ),
          ],
        );
      },
    );
  }
}
