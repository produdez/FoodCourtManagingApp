import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
import '../MyCart/cart_view.dart';

//import '../MyCart/dishes_cart.dart';
/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
class CustomerView extends StatefulWidget {
  final User userData; // userData passed down by the userRouter
  const CustomerView({Key key, this.userData}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<CustomerView> {
  int currentIdx = 0;

  final tabs = [
    Center(
      child: Column(
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
                width: 320, //400
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
          Expanded(child: VendorListView()),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: CartView()),
        ],
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
    //DishDBService.vendorID = widget.userData.id;
  }

  @override
  Widget build(BuildContext context) {
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
                /* setState(() {
                  currentIdx = idx;
                });*/
              },
            ),
          ),
          body: //tabs[currentIdx],
              Center(
            child: Column(
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
                      width: 320, //400
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
                Expanded(child: VendorListView()),
              ],
            ),
          ),
        ));
  }
}
