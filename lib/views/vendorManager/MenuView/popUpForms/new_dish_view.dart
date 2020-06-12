import 'package:fcfoodcourt/models/dish.dart';
import 'package:flutter/material.dart';

import 'confirmation_view.dart';

/*
A form that shows new dish.
The function createNewDishView returns a Future<Dish>
that Dish has all the information of a defaulted dish
(except the id which will be specify when the info is pushed to DB and pulled back)
 */
class NewDishForm extends StatefulWidget {
  @override
  _NewDishFormState createState() => _NewDishFormState();
}

class _NewDishFormState extends State<NewDishForm> {
  String name;
  double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            child: TextField(
              onChanged: (String name) {
                this.name = name;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Dish Name ...",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price:',
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
            child: TextField(
              onChanged: (String price) {
                this.price = double.parse(price);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Price ...",
              ),
            ),
          ),
          Spacer(),
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
                  createConfirmationView(context).then((onValue) {
                    if (onValue == true) {
                      Navigator.of(context).pop(new Dish(name, price));
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<Dish> createPopUpNewDish(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'New Dish Form',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color(0xffff6624),
            ),
          ),
          content: SizedBox(height: 350, width: 300, child: NewDishForm()),
        );
      });
}
