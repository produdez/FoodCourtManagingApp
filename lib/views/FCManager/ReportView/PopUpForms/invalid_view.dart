
//import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/choose_date_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future createPopUpInvalidMessage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              //height: 150,
              //width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 25,),
                  Text(
                    "There is no available report \n Please choose again!!",
                    style: TextStyle(fontSize: 25.0, color: Color(0xfff85f6a), fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xfff85f6a),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Choose Again",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: (){
                    Navigator.of(context).pop(null);
                  },
                  ),
                ],
              ),
            ),
          );
      });
}