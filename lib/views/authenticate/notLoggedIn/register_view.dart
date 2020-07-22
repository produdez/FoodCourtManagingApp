import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/authentication_service.dart';
import 'package:fcfoodcourt/services/input_field_validator.dart';
import 'package:fcfoodcourt/services/staff_db_service.dart';
import 'package:fcfoodcourt/services/user_db_service.dart';
import 'package:fcfoodcourt/services/vendor_db_service.dart';
import 'package:fcfoodcourt/shared/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class RegisterView extends StatefulWidget {

  final Function toggleView;
  RegisterView({ this.toggleView });

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String role = 'Customer';
  String id = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffff8a84),
        elevation: 0.0,
        title: Text('Sign up Food Court'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Email:',
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
                    validator: InputFieldValidator.emailValidator,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email ...",
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Password:',
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
                    obscureText: true,
                    validator: InputFieldValidator.passwordValidator,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password ...",
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Name:',
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
                    validator: RequiredValidator(errorText: 'Phone is required'),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name ...",
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                role =='Customer'|| role =='Food Court Manager' ? Container() : Column(
                  children: <Widget>[
                    Text(
                      'ID:',
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
                        validator: RequiredValidator(errorText: 'Need ID code to verify registration!'),
                        onChanged: (val) {
                          setState(() => id = val);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Manager provided Id ...",
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
                Text(
                  'Your role:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                DropdownButton<String>(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  items: <String>['Vendor Manager', /*'Food Court Manager',*/ 'Staff', 'Customer'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => role = val);
                  },
                  value: role,
                  hint: Text("Customer"),

                ),
                SizedBox(height: 20.0),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xfff85f6a),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        //check if id provided exists for staff and vendor and then proceed, also add account id into db along with staff/vendor db
                        bool canCreateAccount = true;

                        //staff check here
                        if(role== 'Staff') canCreateAccount = await StaffDBService().canCreateStaffAccount(id);
                        //vendor check here
                        if(role == 'Vendor Manager') canCreateAccount = await VendorDBService().canCreateVendorAccount(id);
                        //
                        if(!canCreateAccount){
                          setState(() {
                            loading = false;
                            error = 'Wrong or Used ID code!';
                          });
                        }else{
                          //make account
                          User userData = await _auth.registerWithEmailAndPassword(email: email.trim(), role: role, name: name, password: password.trim());
                          if(userData == null) {
                            setState(() {
                              loading = false;
                              error = 'Error, Can\'t register!';
                            });
                          }else{
                            //update staffDB to link to account if it's staff
                            if(role == 'Staff') {
                              //change back to not waiting
                              await StaffDBService().linkAccount(id, userData.id);
                            }
                            //vendor update here
                            if(role == 'Vendor Manager'){
                              await VendorDBService().linkAccount(id, userData.id);
                              await UserDBService(userData.id).setManageID(id);
                            }
                            //
                          }

                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}