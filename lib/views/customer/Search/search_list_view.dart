import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
//import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:fcfoodcourt/views/customer/Search/search_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/* This is the frame list of dishes. It actively listen to dishDB changes and refresh it's view accordingly
    It also define the function for each button from the dish elements in the list
 */

class SearchListView extends StatefulWidget {
  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  @override
  Widget build(BuildContext context) {
    final List<Dish> dishList = Provider.of<List<Dish>>(context);

    return ListView.builder(
      itemCount: dishList == null ? 0 : dishList.length,
      itemBuilder: (context, index) {
        return SearchItemView(
          dish: dishList[index],
        );
      },
    );
  }
}
