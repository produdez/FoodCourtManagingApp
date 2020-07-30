import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_vendor_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer_dish_list_view.dart';
import 'package:fcfoodcourt/services/search_service.dart';
import 'package:marquee_widget/marquee_widget.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */

//double filter = 0;
// bool firstFilter = false;
// bool secondFilter = false;
// bool thirdFilter = false;
bool inVendor = false;

class CustomerDishView extends StatefulWidget {
  static String vendorId = "";
  static String vendorName = "";
  //const CustomerDishView(this.vendorId, this.vendorName);
  @override
  _MenuViewState createState() => _MenuViewState(vendorId, vendorName);
}

class _MenuViewState extends State<CustomerDishView> {
  String vendorId;
  String vendorName;
  _MenuViewState(this.vendorId, this.vendorName);
  @override
  void initState() {
    DishDBService.vendorID = vendorId;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dish>>.value(
        value: DishDBService().allVendorDishes,
        //value: FilterService().filterByPrice,
        child: WillPopScope(
          onWillPop: () async {
            if (inVendor == false) {
              setState(() {
                CustomerDishView.vendorName = "";
                currentIndex = 0;
              });
              return Future.value(false);
            } else {
              inVendor = false;
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: (currentIndex == 0)
                ? AppBar(
                    backgroundColor: Color(0xffff8a84),
                    title: Marquee(
                      child: Text(
                        vendorName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      direction: Axis.horizontal,
                      textDirection: TextDirection.ltr,
                      animationDuration: Duration(seconds: 1),
                      backDuration: Duration(milliseconds: 1800),
                      pauseDuration: Duration(milliseconds: 1800),
                      directionMarguee: DirectionMarguee.oneDirection,
                    ),
                    centerTitle: true,
                    actions: <Widget>[
                      FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                        ),
                        label: Text('logout'),
                        onPressed: () async {
                          await AuthenticationService().signOut();
                        },
                      )
                    ],
                  )
                : null,
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
                          //inVendor = true;
                          vendorID = vendorId;
                          passToSearchHelper();
                          setState(() {});
                          showSearch(
                                  context: context, delegate: SearchInVendor())
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
                  Expanded(child: CustomerDishListView(vendorName)),
                ],
              ),
            ),
          ),
        ));
  }
}
