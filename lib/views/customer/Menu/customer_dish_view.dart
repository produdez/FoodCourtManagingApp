//import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
//import 'package:fcfoodcourt/services/dish_db_service.dart';
import '../../../models/dish.dart';

/*
This is the vendor element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class CustomerDishView extends StatelessWidget {
  final Dish dish;

  const CustomerDishView({
    Key key,
    this.dish,
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
                onTap: () {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: "ID: ${dish.id}",
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )),
                  child: GFAvatar(
                    backgroundImage: AssetImage(

                        'assets/${dish.id}.jpg'),
                    shape: GFAvatarShape.square,
                    radius: 25,
                    borderRadius: BorderRadius.circular(10),
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
                        dish.name,
                        style: TextStyle(
                            color: Color(0xbb000000),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )),
                  
                  //The price is displayed dynamically by view logic
                  // ViewLogic.displayPrice(context, vendor)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
