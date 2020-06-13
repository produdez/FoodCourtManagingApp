//import 'package:fcfoodcourt/views/vendorManager/MenuView/dish_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:flutter/material.dart';

import 'models/dish.dart';
import 'views/vendorManager/MenuView/menu_view.dart';
import 'views/customer/Menu/home.dart';

/*
This is the root of our app
Routing is used for easy testing and app screen access
Theme is also defined here
TODO: Implement sign-in (customer, owner, FC owner)
 */

void main() => runApp(MaterialApp(
      theme: ThemeData(
          fontFamily: 'QuickSand',
          buttonTheme: ButtonThemeData(
            minWidth: 0,
            height: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )),
      routes: {
        '/': (context) => Home(),
        '/DishMenuView': (context) => MenuView(),
        '/CustomerMenuView': (context) => CustomerView(),
        '/CustomerDishView': (context) => CustomerDishView(),
        //'/DishofVendor': (context) => 
        /*'/ListItemViewTest': (context) => ListItemView(
              dish: new Dish('French Fries', 30),
            ),*/
      },
      initialRoute: '/CustomerMenuView',
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
