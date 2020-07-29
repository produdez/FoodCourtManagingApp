import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/views/authenticate/wrapper.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/item_dish_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/select_type_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/dish.dart';
import 'views/vendorManager/MenuView/menu_view.dart';
//import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

/*
This is the root of our app
Routing is used for easy testing and app screen access
Theme is also defined here
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'QuickSand',
            buttonTheme: ButtonThemeData(
              minWidth: 0,
              height: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )),
        routes: {
          '/login': (context) => Wrapper(),
        },
        initialRoute: '/login',
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
