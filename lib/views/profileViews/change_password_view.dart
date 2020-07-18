import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/input_field_validator.dart';
import 'package:fcfoodcourt/shared/confirmation_view.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TODO: also check ìf new pass collapse old pass.

class ChangePasswordView extends StatefulWidget {
  final User userData;

  const ChangePasswordView({Key key, this.userData}) : super(key: key);
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  String oldPassword='';
  String newPassword='';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget  build(BuildContext context) {
    return loading? Loading(): Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Old Password:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: TextFormField(
                validator: InputFieldValidator.passwordValidator,
                onChanged: (val) {
                  setState(() => oldPassword = val);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Old Password ...",
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'New Password:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: TextFormField(
                obscureText: false,
                validator: InputFieldValidator.passwordValidator,
                onChanged: (val) {
                  setState(() => newPassword = val);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "New Password ...",
                ),
              ),
            ),
            SizedBox(height: 20.0),
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
                    Navigator.of(context).pop(null);
                  },
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
                    if(_formKey.currentState.validate()){
                      createConfirmationView(context).then((onValue) async {
                        print("User Confirm:"+onValue.toString());
                        if (onValue == true) {
                          bool result = await AuthenticationService().checkCorrectPassword(widget.userData.password,oldPassword);
                          if(result==true){
                            //password provided correct
                            String message;
                            setState(() {
                              loading=true;
                            });
                            bool token = await AuthenticationService().changePassword(newPassword);
                            token == true ? message = 'Password changed successfully' : message = 'Error, you might want to log-in again for this operation';
                            Navigator.of(context).pop(message);
                          }else{
                            //password provided non-correct
                            Fluttertoast.showToast(msg: "Wrong password provided!");
                          }


                        }
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}


Future createPopUpChangePassword(BuildContext context, User userData) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'Password Change',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xffff6624),
                ),
              ),
              content: SizedBox(
                  height: 400,
                  width: 300,
                  child: ChangePasswordView(userData: userData,)),
            ),
          ),
        );
      });
}