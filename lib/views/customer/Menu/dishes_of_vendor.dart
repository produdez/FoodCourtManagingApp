import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/views/customer/MyCart/cart_view.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_dish_list_view.dart';
import 'package:fcfoodcourt/services/search_service.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */

//double filter = 0;
// bool firstFilter = false;
// bool secondFilter = false;
// bool thirdFilter = false;

class CustomerDishView extends StatefulWidget {
  final String vendorId;
  final String name;
  //double filter;
  const CustomerDishView(this.vendorId, this.name);
  @override
  _CustomerDishViewState createState() =>
      _CustomerDishViewState(vendorId, name);
}

class _CustomerDishViewState extends State<CustomerDishView> {
  String vendorId;
  String name;

  _CustomerDishViewState(this.vendorId, this.name);

  @override
  void initState() {
    DishDBService.vendorID = vendorId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dish>>.value(
        value: DishDBService().allVendorDishes,
        //value: FilterService().filterByPrice,
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xffff8a84),
              title: Text(
                name,
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
                  selectedIconTheme:
                      IconThemeData(color: Colors.white, size: 25),
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          vendorID = vendorId;
                          setState(() {});
                          showSearch(
                                  context: context, delegate: SearchService())
                              .then((filter) {
                            setState(() {});
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffff8a84), width: 3),
                            ),
                            child: IgnorePointer(
                              child: TextField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search,
                                        size: 30, color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: '   Search....',
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Colors.grey)),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Color(0xffff8a84))),
                        color: firstFilter ? Color(0xffff8a84) : Colors.white,
                        textColor:
                            firstFilter ? Colors.white : Color(0xffff8a84),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          //Colors.white;
                          setState(() {
                            if (firstFilter == false) {
                              firstFilter = true;
                              secondFilter = false;
                              thirdFilter = false;
                              filter = 1;
                            } else {
                              firstFilter = false;
                              filter = 0;
                            }
                          });
                        },
                        child: Text(
                          "< 30.000 đ".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Color(0xffff8a84))),
                        color: secondFilter ? Color(0xffff8a84) : Colors.white,
                        textColor:
                            secondFilter ? Colors.white : Color(0xffff8a84),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          setState(() {
                            if (secondFilter == false) {
                              secondFilter = true;
                              firstFilter = false;
                              thirdFilter = false;
                              filter = 2;
                            } else {
                              secondFilter = false;
                              filter = 0;
                            }
                          });
                        },
                        child: Text(
                          "30.000 đ - 50.000 đ".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Color(0xffff8a84))),
                        color: thirdFilter ? Color(0xffff8a84) : Colors.white,
                        textColor:
                            thirdFilter ? Colors.white : Color(0xffff8a84),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          setState(() {
                            if (thirdFilter == false) {
                              thirdFilter = true;
                              firstFilter = false;
                              secondFilter = false;
                              filter = 3;
                            } else {
                              thirdFilter = false;
                              filter = 0;
                            }
                          });
                        },
                        child: Text(
                          "> 50.000 đ".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
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
          ),
        ));
  }
}
