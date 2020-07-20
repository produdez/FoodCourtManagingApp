import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
A form that shows confirmation.
The function createConfirmationView returns a Future<bool>
which tells if user confirmed or not
 */
class ConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(40),
            //border: Border.all(color: Color(0xfff85f6a), width: 4)
          ),
          height: 250,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Text(
                    "Do you want to order?",
                    style: TextStyle(
                      color: Color(0xffff6624),
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
              Text(
                "  Please confirm!",
                style: TextStyle(
                  color: Color(0xfff85f6a),
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 5,
              ),
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
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> createConfirmationView(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationView();
      });
}
