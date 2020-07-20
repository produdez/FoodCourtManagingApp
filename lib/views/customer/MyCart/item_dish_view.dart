import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:fcfoodcourt/services/cart_service.dart';
import '../../../models/dish.dart';

/*
This is the dish element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class ItemDishView extends StatelessWidget {
  final Dish dish;
  final VoidCallback onRemoveSelected;
  final VoidCallback onEditSelected;
  final VoidCallback onDiscountSelected;

  const ItemDishView(
      {Key key,
      this.dish,
      this.onRemoveSelected,
      this.onEditSelected,
      this.onDiscountSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 400,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FittedBox(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.white,
          elevation: 0,
          borderRadius: BorderRadius.circular(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: "ID: ${dish.id}",
                  );
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                    child: GFAvatar(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: showImage(context)),
                      shape: GFAvatarShape.square,
                      radius: 25,
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          dish.name,
                          style: TextStyle(
                              color: Color(0xbb000000),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        )),
                    ViewLogic.displayPrice(context, dish),
                    SizedBox(height: 2),
                    FlatButton(
                      //TODO: check whether dish is out of stock to fade the button
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Color(0xfff85f6a),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      onPressed: () => CartService().removeDish(dish),

                      ///
                    ),
                  ],
                ),
                //The price is displayed dynamically by view logic
              ) // ViewLogic.displayPrice(context, vendor)
            ],
          ),
        ),
      ),
    );
  }

  Widget showImage(BuildContext context) {
    return FutureBuilder(
      future: ImageUploadService().getImageFromCloud(context, dish.id),
      builder: (context, snapshot) {
        if (dish.hasImage == false ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: MediaQuery.of(context).size.height / 1.25,
              width: MediaQuery.of(context).size.width / 1.25,
              child: Image.asset(
                "assets/bowl.png",
                fit: BoxFit.fill,
              ));
        }
        if (snapshot.connectionState == ConnectionState.done) //image is found
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: snapshot.data,
            //TODO: future builder will keep refreshing while scrolling, find a way to keep data offline and use a stream to watch changes instead.
          );
        return Container();
      },
    );
  }
}
