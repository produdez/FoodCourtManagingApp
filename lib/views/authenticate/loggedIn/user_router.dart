import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/user_db_service.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
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

    return FutureBuilder(
      future: UserDBService(userIdOnly.id).getUserData(),
      builder: (context, snapshot) {
        print("Status: ${snapshot.connectionState.toString()}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else {
          //THIS IS THE USER DATA
          //TODO: pass this down to below classes to use.
          User currentUser = snapshot.data;

          //TODO: Customer Home UI Here
          if (currentUser.role == "Customer") {
            return Container(
              child: Scaffold(
                body: Text("Customer UI"),
                appBar: AppBar(
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
              ),
            );
          }

          //TODO: Vendor Manager Home UI Here
          if (currentUser.role == "Vendor Manager") {
            return VendorManagerNavBar(
              userData: currentUser,
            );
          }

          //TODO: FC manager Home UI Here
          if (currentUser.role == "Food Court Manager") {
            return FoodCourtManagerNavBar(
              userData: currentUser,
            );
          }

          //TODO: Staff Home UI Here
          if (currentUser.role == "Staff") {
            return Container(
              child: Text("Staff UI"),
            );
          }
        }

        //Worst case where everything fail (wont happen i hope :D)
        return Container(
          child: Text("Fail again!"),
        );
      },
    );
  }
}
