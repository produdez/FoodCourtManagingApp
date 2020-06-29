import 'package:fcfoodcourt/views/vendorManager/ReportView/PopUpForms/invalid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'dart:io';
//import 'confirmation_view.dart';
class ChooseDateForm extends StatefulWidget{
  @override 
  _ChooseDateFormState createState() => _ChooseDateFormState();
}

class _ChooseDateFormState extends State<ChooseDateForm>{
  String date;
  String month;
  String year;
  final _formKey = GlobalKey<FormState>();
  @override 
  Widget build(BuildContext context){
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                //icon: Icon(Icons.calendar_today),
                hintText: '1',
                labelText: 'Date',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  )
                ),
              onChanged: (String date)
              {
                this.date = date;
              },
              validator: (date) =>
                  date.contains('@') ? 'Email cannot be blank' : null,
              ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '1',
                labelText: 'Month',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  )
              ),
              onChanged: (String month)
              {
                this.month = month;
              },
              validator: (month)
              {
                if(month.isEmpty){return 'nlil';}
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '2020',
                labelText: 'Year',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  )
              ),
              onChanged: (String year)
              {
                this.year = year;
              },
              validator: (String value)
              {
                if (_formKey.currentState.validate())
                return 'null';
              },
            ),
            SizedBox(height: 25,),
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
                      String validDate = '$date/$month/$year';
                      bool valid = validateInput(date, month, year);
                      if(valid == true)
                      Navigator.of(context).pop(validDate);
                      else
                      createPopUpInvalidMessage(context).then((onValue){});
                    }
              ),
            ],
            )
        ]
      )
    );
}
}
Future createPopUpChooseDate(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Choose Date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color(0xffff6624),
            ),
          ),
          content: SizedBox(height: 275, width: 275, child: ChooseDateForm()),
        );
      });
}
bool validateInput(String date, String month, String year){
  if(isNumeric(month) == false || isNumeric(year) == false || isNumeric(date) == false)
    return false;
  if(month.contains(',') == true || year.contains(',') == true || date.contains(',') == true)
    return false;
  if(month.contains('.') == true || year.contains('.') == true || date.contains('.') == true)
    return false; 
  if(int.parse(month) > 12 && int.parse(month) <= 0)
    return false;
  if(int.parse(year) < 2020)
    return false;
  return true;
}
bool isNumeric(String value)
{
  return int.tryParse(value) != null;
}
/*class TextField extends StatelessWidget{
  final String time;
  final String hintTime;
  
  const TextField(this.time, this.hintTime);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today),
        hintText: this.hintTime,
        labelText: time,
      ),
      validator: ,)
  }
}*/