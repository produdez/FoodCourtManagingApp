import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
//import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/views/customer/MyCart/item_dish_view.dart';
/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class CartDishListView extends StatefulWidget {
  final String vendorID;
  const CartDishListView(this.vendorID);
  @override
  _CartDishListViewState createState() => _CartDishListViewState(vendorID);
}

class _CartDishListViewState extends State<CartDishListView> {
  List<OrderedDish> dishList = [];
  String vendorId;
  _CartDishListViewState(this.vendorId);
  @override
  void initState() {
    for (int i = 0; i < CartService.cart.length; i++) {
      if (CartService.cart[i].vendorID == vendorId)
        dishList = CartService.cart[i].detail;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //CartService.order = new Order();
    return ListView.builder(
      itemCount: dishList.length,
      itemBuilder: (context, index) {
        return ItemDishView(
          dish: dishList[index],
          onRemoveSelected: (OrderedDish dish) {
            setState(() {
              CartService().removeDish(dish);
            });
          },
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
