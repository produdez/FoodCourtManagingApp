import 'package:fcfoodcourt/views/vendorManager/list_item_view.dart';
import 'package:fcfoodcourt/views/vendorManager/new_dish_view.dart';
import 'package:flutter/material.dart';
import 'views/vendorManager/menu_view.dart';
import 'models/dish.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/DishMenuView',
  theme: ThemeData(
    fontFamily: 'QuickSand',
    buttonTheme: ButtonThemeData(
      minWidth: 0,
      height: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    )
  ),
  routes: {
    '/' : (context) => Home(),
    '/DishMenuView' : (context) => MenuView(),
    '/ListItemViewTest' : (context) => ListItemView(dish: new Dish('French Fries', 30),),
  },

));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
