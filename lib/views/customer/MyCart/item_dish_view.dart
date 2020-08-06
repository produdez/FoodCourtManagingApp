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
class ItemDishView extends StatefulWidget {
  final OrderedDish dish;
  final Function(OrderedDish) onRemoveSelected;

  const ItemDishView({
    Key key,
    this.dish,
    this.onRemoveSelected,
  }) : super(key: key);
  @override
  _ItemDishViewState createState() => new _ItemDishViewState(dish);
}

class _ItemDishViewState extends State<ItemDishView> {
  OrderedDish dish;
  _ItemDishViewState(OrderedDish _dish) {
    this.dish = _dish;
  }
  @override
  void initState() {
    // TODO: implement initState
    dish.initQuan = dish.quantity;
    dish.initRev = dish.revenue;
    super.initState();
  }

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
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          dish.name,
                          style: TextStyle(
                              color: Color(0xbb000000),
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
                                "Price: ${dish.revenue}\ Đ",
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
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 3),
                      child: FlatButton(
                        //TODO: check whether dish is out of stock to fade the button
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                        onPressed: () => widget.onRemoveSelected(dish),

                        ///
                      ),
                    )
                  ],
                ),
                //The price is displayed dynamically by view logic
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    dish.quantity != 1
                        ? new IconButton(
                            icon: new Icon(Icons.remove),
                            onPressed: () =>
                                setState(() => CartService().reduceDish(dish)))
                        : new IgnorePointer(
                            child: IconButton(
                                icon: new Icon(
                                  Icons.remove,
                                  color: Colors.grey,
                                ),
                                onPressed: () => setState(
                                    () => CartService().reduceDish(dish)))),
                    new Text(dish.quantity.toString()),
                    new IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: () =>
                            setState(() => CartService().addFromCart(dish)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
