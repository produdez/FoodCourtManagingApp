
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:fcfoodcourt/services/input_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'dart:io';
import '../../../../shared/confirmation_view.dart';

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
  String price;
  String imageURL;
  ImageUploadService _imageUploadService = ImageUploadService();
  File _image;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GFAvatar(
                shape: GFAvatarShape.square,
                radius: 50,
                backgroundColor: Colors.transparent,
                child: ClipRect(
                  child: new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: _image == null?
                    Image.asset("assets/bowl.png", fit: BoxFit.fill,):
                    Image.file(_image,fit: BoxFit.fill,),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    File returnImage = await _imageUploadService.getImageFromImagePicker();
                    setState(() {
                      _image = returnImage;
                    });
                  },
                ),
              ),
            ],
          ),
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
              validator: RequiredValidator(errorText: 'Name is required'),
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
            child: TextFormField(
//              validator: InputFieldValidator.priceValidator,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Price is required'),
                NumberValidator(max: null,min: null,errorText: 'Enter a number'),
                NumberValidator(min: 0, errorText: 'Price must be non-negative'),
              ]),
              onChanged: (String price) {
                this.price = price;
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
                  if(_formKey.currentState.validate()){
                    createConfirmationView(context).then((onValue) async {
                      if (onValue == true) {
                        bool hasImage = _image!=null? true:false;
                        Navigator.of(context).pop(new Dish(name, double.parse(price), imageFile: _image,hasImage:hasImage));
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

Future<Dish> createPopUpNewDish(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'New Dish Form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xffff6624),
                ),
              ),
              content: SizedBox(height: 420, width: 300, child: NewDishForm()),
            ),
          ),
        );
      });
}

