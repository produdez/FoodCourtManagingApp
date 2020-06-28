import 'package:fcfoodcourt/models/dish.dart';
//import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class CustomerDishListView extends StatefulWidget {
  @override
  _CustomerDishListViewState createState() => _CustomerDishListViewState();
}

class _CustomerDishListViewState extends State<CustomerDishListView> {
  @override
  Widget build(BuildContext context) {
    final List<Dish> dishList = Provider.of<List<Dish>>(context);
    return ListView.builder(
      itemCount: dishList.length,
      itemBuilder: (context, index) {
        return CustomerDishView(
          dish: dishList[index],
          /*onRemoveSelected: () {
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
          },*/
        );
      },
    );
  }
}