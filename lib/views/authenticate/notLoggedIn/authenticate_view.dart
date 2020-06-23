
import 'package:flutter/material.dart';

import 'login_view.dart';
import 'register_view.dart';

/*
This class allows to switch between Log-in and Register View
 */
class AuthenticateView extends StatefulWidget {
  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginView(toggleView:  toggleView);
    } else {
      return RegisterView(toggleView:  toggleView);
    }
  }
}