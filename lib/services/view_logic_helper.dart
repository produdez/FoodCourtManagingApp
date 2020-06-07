
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewLogic{
  static displayPrice(BuildContext context, Dish dish){
    if(dish.realPrice == dish.originPrice){ //case not discounted, just show original
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
    }else{ // case discounted, we return row with crossed original price, new price and discount label
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
                //TODO: Figure out a way to make the discounted price shows up instead of the original price when dish's discounted
                //TODO: Think of an efficient discount system
                //TODO: Which price to use when printing bill? discounted or normal price,....?? Questions here!!
                "DISCOUNT ${HelperService.formatDouble(dish.discountPercentage,decimalToKeep: 0)}%",
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