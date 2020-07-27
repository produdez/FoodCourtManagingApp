import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/views/staff/order_db_service.dart';
import 'package:fcfoodcourt/views/staff/ordered_dish_detail.dart';
import 'package:flutter/material.dart';
import 'order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 400.0,
            //child: Image.asset(widget.imagePath, fit: BoxFit.cover),
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
            left: -20.0,
            bottom: 0.0,
            right: 10.0,
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
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
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
                color: Colors.green,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                  Navigator.pop(context);
                  Firestore.instance
                      .collection('orderDB')
                      .document(order.id)
                      .delete();
                },
                child: Text('Finish'),
              )
            ],
            title: Text('Finish order?'),
          );
        });
  }
}
