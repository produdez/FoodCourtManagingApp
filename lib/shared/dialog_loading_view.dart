import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 150.0,
              child: Container(
                key: key,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Center(
                  child: SpinKitChasingDots(
                    color: Color(0xfff85f6a),
                    size: 50.0,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please Wait....",
                    style: TextStyle(color: Color(0xfff85f6a), fontSize: 25, fontWeight: FontWeight.bold)
                  ),
                  ]
                ),
              ),
            )
          );
        });
  }
}
