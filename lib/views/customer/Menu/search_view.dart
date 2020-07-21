import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/views/customer/MyCart/cart_view.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_dish_list_view.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
class SearchView extends StatefulWidget {
  final String vendorId;

  const SearchView(this.vendorId);
  @override
  _MenuViewState createState() => _MenuViewState(vendorId);
}

class _MenuViewState extends State<SearchView> {
  String vendorId;

  _MenuViewState(this.vendorId);

  @override
  void initState() {
    DishDBService.vendorID = vendorId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(name);
    return StreamProvider<List<Dish>>.value(
      value: DishDBService().allVendorDishes,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "Food",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          height: 75,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 4, color: Colors.black),
          )),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              iconSize: 25,
              backgroundColor: Color(0xffff8a84),
              selectedFontSize: 20,
              unselectedFontSize: 20,
              selectedItemColor: Colors.white,
              currentIndex: 0,
              selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant),
                    title: Text(
                      "Menu",
                    )),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("MyCart"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                ),
              ],
              onTap: (idx) {
                if (idx == 1)
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartView()));
              }),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // try to centre the search box without relying much on it width
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: CustomerDishListView()),
          ],
        ),
      ),
    );
  }
}
