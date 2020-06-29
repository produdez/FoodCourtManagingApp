import 'dart:io';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/views/FCManager/ReportView/select_type_view.dart';
import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/choose_date_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvalidForm extends StatefulWidget{
  @override 
  _InvalidForm createState() => _InvalidForm();
}

class _InvalidForm extends State<InvalidForm>{
  User userData;
  @override 
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => SelectTypeView())
                  );
                }
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Color(0xfff85f6a),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                      Navigator.of(context).pop(null); 
                    }
              ),
            ],
            )
      ]
      );
  }
}
Future createPopUpInvalidMessage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Invalid time\nPlease choose again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color(0xffff6624),
            ),
          ),
          content: SizedBox(
            height: 75, 
            width: 225, 
            child: InvalidForm(),
          ),
        );
      });
}