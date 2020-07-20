import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/views/authenticate/wrapper.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/dish.dart';
import 'views/vendorManager/MenuView/menu_view.dart';

/*
This is the root of our app
Routing is used for easy testing and app screen access
Theme is also defined here
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
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
          '/login': (context) => Wrapper(),
          '/ListItemViewTest': (context) => ItemDishView(
                dish: new Dish('French Fries', 30),
              ),
          '/CustomerMenuView': (context) => CustomerView(),
          // '/CustomerDishView': (context) => CustomerDishView(),
        },
        initialRoute: '/login',
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
