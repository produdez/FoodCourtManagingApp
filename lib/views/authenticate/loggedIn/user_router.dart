import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/services/user_db_service.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:fcfoodcourt/views/customer/customer_nav_bar.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/menu_view.dart';
import 'package:fcfoodcourt/views/FCManager/bottom_navigation_view_fc_manager.dart';
import 'package:fcfoodcourt/views/vendorManager/bottom_navigation_view_vendor_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wrapper.dart';

/*
After user log-in, this will route them to their correct screen
You must pass the currentUser down to the child class in order to user them
 */
class LoggedInUserRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userIdOnly = Provider.of<User>(context);
    if (userIdOnly == null) return Wrapper();

    return StreamProvider<User>.value(
      value: UserDBService(userIdOnly.id).user,
      child: FutureBuilder(
        future: UserDBService(userIdOnly.id).getUserData(),
        builder: (context, snapshot) {
          print("Status: ${snapshot.connectionState.toString()}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            //THIS IS THE USER DATA
            User currentUser = snapshot.data;

            //Customer Home UI Here
            if (currentUser.role == "Customer") {
              return CustomerNavBar(userData: currentUser);
            }

            //Vendor Manager Home UI Here
            if (currentUser.role == "Vendor Manager") {
              return VendorManagerNavBar();
            }

            //FC manager Home UI Here
            if (currentUser.role == "Food Court Manager") {
              return FoodCourtManagerNavBar();
            }

            //Staff Home UI Here
            if (currentUser.role == "Staff") {
              return FutureBuilder(
                future: StaffDBService().staffInfoFromAccountId(
                    currentUser.id), //get staff info from account id of staff
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('Out'),
                        onPressed: () => AuthenticationService().signOut(),
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            snapshot.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('Out'),
                            onPressed: () => AuthenticationService().signOut(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          }

          //Worst case where everything fail (wont happen i hope :D)
          return Container(
            child: Text("Fail again!"),
          );
        },
      ),
    );
  }
}
