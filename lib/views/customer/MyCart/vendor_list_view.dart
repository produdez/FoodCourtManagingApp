import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
//import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/customer/MyCart/vendor_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class VendorListView extends StatefulWidget {
  @override
  _VendorListViewState createState() => _VendorListViewState();
}

class _VendorListViewState extends State<VendorListView> {
  @override
  Widget build(BuildContext context) {
    final List<Order> vendorList = CartService.cart;

    return ListView.builder(
      itemCount: vendorList.length,
      itemBuilder: (context, index) {
        return VendorView(
          vendor: vendorList[index],
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
