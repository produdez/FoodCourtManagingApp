import 'package:fcfoodcourt/services/manage_menu_service.dart';
import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/views/vendorManager/confirmation_view.dart';
import 'package:flutter/material.dart';
import '../../models/dish.dart';
import 'package:getflutter/getflutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListItemView extends StatelessWidget {
  final Dish dish;
  final VoidCallback onRemoveSelected;
  final VoidCallback onEditSelected;
  final VoidCallback onDiscountSelected;

  const ListItemView(
      {Key key, this.dish, this.onRemoveSelected, this.onEditSelected, this.onDiscountSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool discounted = dish.discountPercentage != 0 ? true : false;
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
                    msg: "ID: ${dish.id}",);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Text(
                            dish.name,
                            style: TextStyle(
                                color: Color(0xffffa834),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          )),
                      //TODO: call logic function to return the correct row for price here
                      ViewLogic.displayPrice(context, dish),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xfff85f6a),
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            onPressed: () => onRemoveSelected(),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xfff85f6a),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            onPressed: () {
                              onEditSelected();
                            },
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xfff85f6a),
                            child: Text(
                              'Discount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            onPressed: () {
                              onDiscountSelected();
                            },
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
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
