


import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/user_db_service.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
import 'package:fcfoodcourt/views/vendorManager/MenuView/menu_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wrapper.dart';
/*
After user log-in, this will route them to their correct screen
 */
class LoggedInUserRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userIdOnly = Provider.of<User>(context);
    if(userIdOnly== null) return Wrapper();

    return FutureBuilder(
      future: UserDBService(userIdOnly.id).getUserData(),
      builder: (context, snapshot){
        print("Status: ${snapshot.connectionState.toString()}");
        if(snapshot.connectionState == ConnectionState.waiting){
          return Loading();
        }else{
          User currentUser = snapshot.data;
          if(currentUser.role == "Customer"){
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
                      },)
                  ],
                ),
              ),
            ); //TODO: Customer Home UI Here
          }

          if(currentUser.role == "Vendor Manager"){
            return MenuView();
            //TODO: Vendor Manager Home UI Here
          }

          if(currentUser.role == "Food Court Manager") {
            return Container(
              child: Text("FC Manager UI"),
            );//TODO: FC manager Home UI Here
          }

          if(currentUser.role == "Staff") {
            return Container(
              child: Text("Staff UI"),
            ); //TODO: Staff Home UI Here
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