import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_dish_list_view.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
class CustomerDishView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<CustomerDishView> {
  //@override
  /*void initState() {
    // TODO:random populate database only when needed
    //VendorDBService().populateDatabaseRandom();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dish>>.value(
      value: DishDBService().allVendorDishes,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "FODDER",
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
            currentIndex: 0,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant),
                  title: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
          ),
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
                Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  width: 320,//400
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffff8a84), width: 4),
                  ),
                  
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: '   Search....'),
                  ),
                ),
                Icon(Icons.search, size: 50, color: Color(0xffff8a84)),
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
