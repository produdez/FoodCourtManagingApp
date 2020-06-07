import 'dart:ui';

import 'package:fcfoodcourt/models/local_menu_data.dart';
import 'package:fcfoodcourt/services/manage_menu_service.dart';
import 'package:fcfoodcourt/views/vendorManager/confirmation_view.dart';
import 'package:fcfoodcourt/views/vendorManager/discount_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/edit_dish_view.dart';
import 'package:fcfoodcourt/views/vendorManager/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../models/dish.dart';
import 'new_dish_view.dart';

//View data
List<Dish> menuViewData;
//Service instance
ManageMenuService manageMenuService = ManageMenuService();
class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    //First run, populate the list with fake data
    manageMenuService.populateMenuRandom();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //have to refresh view data every time rebuild
    menuViewData = manageMenuService.getMenuDishList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffff8a84),
        title: Text(
          "VENDOR MENU",
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
              icon: Icon(Icons.work),
              title: Text("Staff"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              title: Text("Report"),
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
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffff8a84), width: 4),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0),
                      hintText: '   Search....'),
                ),
              ),
              Icon(Icons.search, size: 50, color: Color(0xffff8a84)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuViewData.length,
              itemBuilder: (context, index) {
                return ListItemView(
                  dish: menuViewData[index],
                  onRemoveSelected: (){
                    createConfirmationView(context).then((onValue){
                      if(onValue==true)
                        {
                          manageMenuService.removeDish(menuViewData[index]);
                          refreshView();
                        }
                    });
                    },
                  onEditSelected: (){
                    createPopUpEditDish(context, menuViewData[index]).then((onValue){
                      if(onValue != null){
                        manageMenuService.editDish(menuViewData[index], onValue);
                        refreshView();
                      }
                    });
                  },
                  onDiscountSelected: (){
                    createPopUpDiscountDish(context, menuViewData[index]).then((onValue){
                      if(onValue != null){
                        manageMenuService.discountDish(menuViewData[index],onValue);
                        refreshView();
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff8a84),
        onPressed: () {
          createPopUpNewDish(context).then((onValue){
            if(onValue!=null){
              manageMenuService.newDish(onValue);
              refreshView();
            }
          }); //This request the pop-up new dish form
        },
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  void refreshView()
  {
    setState(() {
      menuViewData = manageMenuService.getMenuDishList();
    });
  }
}