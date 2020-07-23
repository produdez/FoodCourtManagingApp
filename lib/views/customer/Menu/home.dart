import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:fcfoodcourt/views/customer/Menu/vendor_list_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/vendor_view.dart';
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
  CustomerView({Key key, this.userData}) : super(key: key);
  String vendorId;
  String vendorName;

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<CustomerView> {
  static int currentIndex = 0;
  final List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    children.add(VendorListView(
      onVendorSelected: (String id, String name) {
        print(name);
        setState(() {
          currentIndex = 1;
          CustomerDishView.vendorId = id;
          CustomerDishView.vendorName = name;
        });
      },
    ));
    children.add(CustomerDishView());
    Order.customerID = widget.userData.id;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Vendor>>.value(
        value: VendorDBService().allVendor,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // leading: (currentIndex == 1)
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: <Widget>[
            //           IconButton(
            //               icon: Icon(Icons.arrow_back),
            //               onPressed: () {
            //                 setState(() {
            //                   currentIndex = 0;
            //                 });
            //               })
            //         ],
            //       )
            //     : SizedBox(),
            backgroundColor: Color(0xffff8a84),
            title: Text(
              "FOOD COURT",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await AuthenticationService().signOut();
                },
              )
            ],
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
                Expanded(child: children[currentIndex]),
              ],
            ),
          ),
        ));
  }
}
