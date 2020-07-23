import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/views/customer/MyCart/pop_order.dart';

//import 'package:fcfoodcourt/views/vendorManager/MenuView/popUpForms/new_dish_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
import 'cart_dish_list_view.dart';
import 'vendor_list_view.dart';

/*
This is the menu view that holds the frame for the whole menu
It does holds the add Dish button
 */
class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO:random populate database only when needed
    //VendorDBService().populateDatabaseRandom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var totalPrice = CartService.totalPrice;
    return //StreamProvider<List<Dish>>.value(
        //value: CartService().allOrderDishes,
        //child:
        Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffff8a84),
        title: Text(
          "MY CART",
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
            SizedBox(
              height: 10,
            ),
            Expanded(child: VendorListView()),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                // try to centre the search box without relying much on it width
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 65,
                    width: 280, //400
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff85f6a), width: 4),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Text(totalPrice.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                )))
                      ],
                    ),
                  ),
                  /*SizedBox(
                        width: 8,
                      ),*/
                  // ignore: missing_required_param
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 65,
                    width: 80, //400
                    decoration: BoxDecoration(
                      color: Color(0xfff85f6a),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              createConfirmationView(context)
                                  .then((onValue) {});
                            },
                            child: Container(
                                child: Text('ORDER',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))))
                      ],
                    ),
                  )
                ]),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffff8a84),
            onPressed: () {
              //On newDish chosen, show newDish popUp and process information
              //The return value is a Dish with name, price (every other fields are defaulted)
              /*createPopUpNewDish(context).then((onValue) {
              if (onValue != null) {
                DishDBService().addDish(onValue);
              }
            });*/ //This request the pop-up new dish form
            },
            child: Icon(
              Icons.add,
              size: 50,
            ),
          ),)*/
    );
  }
}
