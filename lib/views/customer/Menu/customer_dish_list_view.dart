import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/search_service.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class CustomerDishListView extends StatefulWidget {
  final String vendorName;
  const CustomerDishListView(this.vendorName);
  @override
  _CustomerDishListViewState createState() =>
      _CustomerDishListViewState(vendorName);
}

class _CustomerDishListViewState extends State<CustomerDishListView> {
  String vendorName;
  _CustomerDishListViewState(this.vendorName);
  @override
  Widget build(BuildContext context) {
    final List<Dish> dishList = Provider.of<List<Dish>>(context);
    return ListView.builder(
      itemCount: dishList == null ? 0 : dishList.length,
      itemBuilder: (context, index) {
        return ItemDishView(
          dish: dishList[index],
          vendorName: vendorName,
        );
      },
    );
  }
}
