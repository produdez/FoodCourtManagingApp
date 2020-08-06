import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/menu_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/services/search_service.dart';

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
    SearchForDish.dishList = dishList;
    return ListView.builder(
      itemCount: dishList == null ? 0 : dishList.length,
      itemBuilder: (context, index) {
        return ItemDishView(
          dish: dishList[index],
          onRemoveSelected: () =>
              MenuViewController.removeDish(context, dishList[index]),
          onEditSelected: () =>
              MenuViewController.editDish(context, dishList[index]),
          onDiscountSelected: () =>
              MenuViewController.discountDish(context, dishList[index]),
        );
      },
    );
  }
}
