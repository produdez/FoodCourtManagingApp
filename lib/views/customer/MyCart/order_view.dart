import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
import '../../../models/dish.dart';

/*
This is the dish element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class OrderView extends StatelessWidget {
  final Order order;

  const OrderView({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 465,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          order.vendorName,
                          style: TextStyle(
                              color: Color(0xfff85f6a),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: SizedBox(
                              height: 20,
                              width: 100,
                              child: Text(
                                "Price: ${order.totalPrice}\ Đ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ),
              Container(
                  child: Column(children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text((order.inform == true) ? "    Ready" : "Processing  ",
                        style: TextStyle(
                            color: (order.inform == true)
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12))
                  ],
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
