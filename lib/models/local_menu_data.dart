

import 'package:fcfoodcourt/models/dish.dart';
import 'package:flutter/cupertino.dart';

class LocalMenuData
{

  static List<Dish> menu = new List(); //database (local)
  static int newID =0;
  void add(Dish dish){
    menu.add(dish);
    dish.id = newID;
    newID++;
  }
  void remove(Dish dish) {
    menu.remove(dish);
  }
  int getLength() => menu.length;
  List<Dish> getMenu()=> menu;
  Dish getDish(int id) {
    for(Dish dish in menu){
      if(dish.id == id) return dish;
    }
    return null;
  }
  void editDish(Dish dish, Dish newDish) {
    menu[menu.indexOf(dish)] = newDish;
  }
}