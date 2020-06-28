
import 'package:fcfoodcourt/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loggedIn/user_router.dart';
import 'notLoggedIn/authenticate_view.dart';

/*
Wrap around our app and keep checking for log-in status
display Log-in/Register or Home page depending on user's status
 */
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either the Home or Authenticate widget
    if (user == null){
      return AuthenticateView();
    } else {
      return LoggedInUserRouter();
    }

  }
}