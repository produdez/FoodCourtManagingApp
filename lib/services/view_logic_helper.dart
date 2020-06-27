import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//special pieces of view that needs logic
class ViewLogic {
  //the price of a dish must be dynamically shown depending on weather it's discounted or not
  static displayPrice(BuildContext context, Dish dish) {
    if (dish.realPrice == dish.originPrice) {
      //case not discounted, just show original
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "Price: ${dish.realPrice}\$",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 8,
              ),
            ),
          ),
        ],
      );
    } else {
      // case discounted, we return row with crossed original price, new price and discount label
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  "Price: ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 8,
                  ),
                ),
                Text(
                  "${dish.originPrice}\$",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 8,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  " ${dish.realPrice}\$",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                "DISCOUNT ${HelperService.formatDouble(dish.discountPercentage, decimalToKeep: 0)}%",
                style: TextStyle(
                  color: Color(0xffff6624),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      );
    }
  }
}
