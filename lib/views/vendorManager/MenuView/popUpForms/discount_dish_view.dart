import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/helper_service.dart';
import 'package:fcfoodcourt/services/input_field_validator.dart';
import 'package:flutter/material.dart';

import '../../../../shared/confirmation_view.dart';

/*
A form that shows discount.
The function createDiscountDishView returns a Future<Dish>
that Dish only contains discount information
 */
class DiscountDishForm extends StatefulWidget {
  final Dish dish;

  const DiscountDishForm({Key key, this.dish}) : super(key: key);

  @override
  _DiscountDishFormState createState() => _DiscountDishFormState();
}

class _DiscountDishFormState extends State<DiscountDishForm> {
  double discountedPrice;
  double discountedPercentage;
  var priceInputController = TextEditingController();
  var percentageInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    discountedPrice = widget.dish.originPrice;
    discountedPercentage = widget.dish.discountPercentage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Original Price: ${widget.dish.originPrice}\$",
            style: TextStyle(
              color: Color(0xffff6624),
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Discounted Price:',
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
              validator: InputFieldValidator.priceValidator,
              controller: priceInputController,
              onChanged: (String price) {
                if (price != "") {
                  discountedPrice = double.parse(price);
                  discountedPercentage =
                      (widget.dish.originPrice - discountedPrice) /
                          widget.dish.originPrice *
                          100;
                  percentageInputController.text =
                      HelperService.formatDouble(discountedPercentage) + "%";
                } else {
                  percentageInputController.text = "";
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    "${HelperService.formatDouble(widget.dish.realPrice)}\$",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Discounted Percentage:',
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
              validator: InputFieldValidator.percentageValidator,
              controller: percentageInputController,
              onChanged: (String percentage) {
                if (percentage != "") {
                  discountedPercentage = double.parse(percentage);
                  discountedPrice = widget.dish.originPrice -
                      widget.dish.originPrice * discountedPercentage / 100;
                  priceInputController.text =
                      HelperService.formatDouble(discountedPrice);
                } else {
                  priceInputController.text = "";
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    "${HelperService.formatDouble(widget.dish.discountPercentage)}%",
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
                    if(_formKey.currentState.validate()){
                      createConfirmationView(context).then((onValue) {
                          if (onValue == true) {
                            Navigator.of(context).pop(new Dish(null, null,
                                discountPercentage: discountedPercentage,
                                realPrice: discountedPrice));
                          }
                      });
                    }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<Dish> createPopUpDiscountDish(BuildContext context, Dish dish) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'Discount Dish Form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xffff6624),
                ),
              ),
              content: SizedBox(
                  height: 350,
                  width: 300,
                  child: DiscountDishForm(
                    dish: dish,
                  )),
            ),
          ),
        );
      });
}
