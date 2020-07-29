import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dish_db_services.dart';
import 'dish.dart';
import 'dish_list.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    //OrderDBService.vendorID =
    super.initState();
    //VendorReportDBService().createDailyReport(null);
    //IMPORTANT: HAVE TO SET THE SERVICE'S VENDOR ID FROM HERE
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dish>>.value(
      value: DishDBServices().dishes,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffff8a84),
          title: Text(
            "VENDOR MENU",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: DishList(),
      ),
    );
  }
}
