import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/search_service.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/services/view_logic_helper.dart';
import '../MyCart/cart_view.dart';

//import 'package:flushbar/flushbar.dart';
//import '../MyCart/dishes_cart.dart';
/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */

class CustomerView extends StatefulWidget {
  final User userData; // userData passed down by the userRouter
  const CustomerView({Key key, this.userData}) : super(key: key);

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  int currentIdx = 0;
  String keyword;
  List<String> _print;
  User user;
  @override
  void initState() {
    // user = userData;
    super.initState();

    //print(list[2]);

    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
    //DishDBService.vendorID = widget.userData.id;
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = ['khoi', 'va', 'minh'];

    return StreamProvider<List<Vendor>>.value(
        value: VendorDBService().allVendor,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color(0xffff8a84),
              title: Text(
                "FOOD COURT",
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
                currentIndex: currentIdx, //
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartView()));
                },
              ),
            ),
            body: WillPopScope(
              onWillPop: onWillPop,
              child: Center(
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
                          onTap: () async {
                            //_print = _setListString(list);
                            // setListString(list, user.id).then((onValue) {
                            //   _print = onValue;
                            //   print(_print[2]);
                            // });

                            // print(_print[2]);
                            vendorID = "";
                            SearchService().passToSearchHelper();
                            showSearch(
                                context: context, delegate: SearchService());
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
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
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
                    Expanded(child: VendorListView()),
                  ],
                ),
              ),
            )));
  }
}
