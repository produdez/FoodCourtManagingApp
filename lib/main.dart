import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/select_type_view.dart';
import 'package:flutter/material.dart';

import 'models/dish.dart';
import 'views/vendorManager/MenuView/menu_view.dart';

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
        '/VendorReportView': (context) => SelectTypeView(),
      },
      initialRoute: '/VendorReportView',
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
