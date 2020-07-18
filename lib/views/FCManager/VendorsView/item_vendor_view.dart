import 'package:fcfoodcourt/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';


/*
This is the vendor element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class ItemVendorView extends StatelessWidget {
  final Vendor vendor;
  final VoidCallback onRemoveSelected;
  final VoidCallback onEditSelected;
  final VoidCallback onCallSelected;

  const ItemVendorView(
      {Key key,
      this.vendor,
      this.onRemoveSelected,
      this.onEditSelected,
      this.onCallSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 0,
          borderRadius: BorderRadius.circular(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                //TODO: remove after debug
                onTap: () {
                  print(vendor.toString());
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: vendor.toString(),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      )),
                  child: GFAvatar(
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: showImage(context)
                    ),
                    shape: GFAvatarShape.square,
                    radius: 25,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    vendor.name,
                    style: TextStyle(
                        color: Color(0xffffa834),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )),

                  //The price is displayed dynamically by view logic
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Phone: ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          "${vendor.phone}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
                        onPressed: () => onRemoveSelected(),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Color(0xfff85f6a),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        onPressed: () {
                          onEditSelected();
                        },
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      FlatButton(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Color(0xfff85f6a),
                        child: Text(
                          'Call',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        onPressed: () {
                          onCallSelected();
                        },
                      ),
                      SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget showImage(BuildContext context){
    if(vendor.hasImage==false){
      return Container(
          height: MediaQuery.of(context).size.height /
              1.25,
          width: MediaQuery.of(context).size.width /
              1.25,
          child: Image.asset("assets/vendor.png", fit: BoxFit.fill,));
    }else if(vendor.imageURL==null){
      return CircularProgressIndicator();
    }else{
      return Container(
        height:
        MediaQuery.of(context).size.height,
        width:
        MediaQuery.of(context).size.width,
        child: Image.network(
          vendor.imageURL,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
