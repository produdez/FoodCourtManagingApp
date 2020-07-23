import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/views/customer/MyCart/cart_view.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_dish_list_view.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
class CustomerDishView extends StatefulWidget {
  static String vendorId;
  static String vendorName;
  //const CustomerDishView(this.vendorId, this.vendorName);
  @override
  _MenuViewState createState() => _MenuViewState(vendorId, vendorName);
}

class _MenuViewState extends State<CustomerDishView> {
  String vendorId;
  String vendorName;
  _MenuViewState(this.vendorId, this.vendorName);
  @override
  void initState() {
    DishDBService.vendorID = vendorId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dish>>.value(
      value: DishDBService().allVendorDishes,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: CustomerDishListView(
                    vendorName)), //vendorname needed for cart
          ],
        ),
      ),
    );
  }
}
