import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/views/staff/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'profile_page.dart';

/*
This is the Staff view that holds the frame for the whole Staff
It does holds the add Dish button
 */
class StaffView extends StatefulWidget {
  final User userData; // userData passed down by the userRouter
  const StaffView({Key key, this.userData}) : super(key: key);
  @override
  _StaffViewState createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  int currentTab = 0;

  // Pages
  OrderPage orderPage;
  MenuPage menuPage;
  ProfilePage profilePage;

  List<Widget> pages;
  Widget currentPage;
  @override
  void initState() {
    orderPage = OrderPage();
    menuPage = MenuPage();
    profilePage = ProfilePage();
    pages = [orderPage, menuPage, profilePage];
    currentPage = orderPage;
    super.initState();
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
    DishDBService.vendorID = widget.userData.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffff8a84),
          selectedItemColor: Colors.white,
          currentIndex: currentTab,
          onTap: (index) {
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            });
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              title: Text("Orders"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant,
              ),
              title: Text("Menu"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text("Profile"),
            ),
          ],
        ),
        body: currentPage,
      ),
    );
  }
}
