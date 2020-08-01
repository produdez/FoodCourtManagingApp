import 'dart:ui';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/profileViews/profile_view.dart';
import 'package:fcfoodcourt/services/search_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Menu/home.dart';
import 'MyCart/cart_view.dart';

class CustomerNavBar extends StatefulWidget {
  final User userData;

  CustomerNavBar({
    Key key,
    this.userData,
  }) : super(key: key);
  @override
  _CustomerNavBarState createState() => _CustomerNavBarState(userData);
}

class _CustomerNavBarState extends State<CustomerNavBar> {
  User userData;
  int currentIndex = 0;
  final List<Widget> children = [];
  _CustomerNavBarState(this.userData);

  @override
  void initState() {
    super.initState();
    children.add(CustomerView(
      userData: widget.userData,
    ));
    children.add(CartView());
    children.add(ProfileView());
    //children.add(ManageStaffView(userData: widget.userData,));
    //TODO: Add report route here
  }

  @override
  Widget build(BuildContext context) {
    cusID = userData.id;
    return Scaffold(
      resizeToAvoidBottomInset: false, // address bottom overflow error
      //resizeToAvoidBottomPadding: false,
      body: children[currentIndex],
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 4, color: Colors.black),
        )),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
          iconSize: 25,
          backgroundColor: Color(0xffff8a84),
          selectedFontSize: 20,
          unselectedFontSize: 20,
          currentIndex: currentIndex,
          selectedLabelStyle: TextStyle(
              //color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          //showSelectedLabels: true,
          showUnselectedLabels: true,
          // selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.black, size: 25),
          //selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.restaurant),
              title: Text("Menu"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.work),
              title: Text("Cart"),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffff8a84),
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
