import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/confirmation_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/discount_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/edit_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class DishListView extends StatefulWidget {
  @override
  _DishListViewState createState() => _DishListViewState();
}

class _DishListViewState extends State<DishListView> {
  @override
  Widget build(BuildContext context) {
    final List<Dish> dishList = Provider.of<List<Dish>>(context);

    return ListView.builder(
      itemCount: dishList == null ? 0 : dishList.length,
      itemBuilder: (context, index) {
        return ItemDishView(
          dish: dishList[index],
          onRemoveSelected: () {
            //Remove chosen, ask user for confirmation and remove in DB if confirmed
            createConfirmationView(context).then((onValue) {
              if (onValue == true) {
                DishDBService().removeDish(dishList[index]);
              }
            });
          },
          onEditSelected: () {
            //Edit chosen, show edit form and process returned information
            //The return value is Dish with name and price (no realPrice,...)
            createPopUpEditDish(context, dishList[index]).then((onValue) {
              if (onValue != null) {
                DishDBService().editDish(dishList[index], onValue);
              }
            });
          },
          onDiscountSelected: () {
            //Discount chosen, show discount form and process returned information
            //The return value is Dish with discounted price and percentage (no name,...)
            createPopUpDiscountDish(context, dishList[index]).then((onValue) {
              if (onValue != null) {
                DishDBService().discountDish(dishList[index], onValue);
              }
            });
          },
        );
      },
    );
  }
}
