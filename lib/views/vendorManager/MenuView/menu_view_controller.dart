

import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/discount_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/edit_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';

class MenuViewController{
  static void addDish(BuildContext context){
    //On newDish chosen, show newDish popUp and process information
    //The return value is a Dish with name, price (every other fields are defaulted)
    createPopUpNewDish(context).then((onValue) {
      if (onValue != null) {
        DishDBService().addDish(onValue);
      }
    }); //This request the pop-up new dish form
  }

  static void removeDish(BuildContext context, Dish dish){
    //Remove chosen, ask user for confirmation and remove in DB if confirmed
    createConfirmationView(context).then((onValue) {
      if (onValue == true) {
        DishDBService().removeDish(dish);
      }
    });
  }
  static void editDish(BuildContext context, Dish dish){
    //Edit chosen, show edit form and process returned information
    //The return value is Dish with name and price (no realPrice,...)
    createPopUpEditDish(context, dish).then((onValue) {
      if (onValue != null) {
        DishDBService().editDish(dish, onValue);
      }
    });
  }
  static void discountDish(BuildContext context, Dish dish){
    //Discount chosen, show discount form and process returned information
    //The return value is Dish with discounted price and percentage (no name,...)
    createPopUpDiscountDish(context, dish).then((onValue) {
      if (onValue != null) {
        DishDBService().discountDish(dish, onValue);
      }
    });
  }
}