import 'package:fcfoodcourt/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';


/*
This is the dish element in the list view
it has call back fields so that the parent that contains this can specify
it's functionality.
 */
class ItemStaffView extends StatelessWidget {
  final Staff staff;
  final VoidCallback onRemoveSelected;
  final VoidCallback onEditSelected;
  final VoidCallback onCallSelected;

  const ItemStaffView(
      {Key key,
        this.staff,
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
                  print(staff.toString());
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                    msg: staff.toString(),
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
                            staff.name,
                            style: TextStyle(
                                color: Color(0xffffa834),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Position: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              "${staff.position}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              "${staff.phone}",
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
    if(staff.hasImage==false){
      return Container(
          height: MediaQuery.of(context).size.height /
              1.25,
          width: MediaQuery.of(context).size.width /
              1.25,
          child: Image.asset("assets/bowl.png", fit: BoxFit.fill,));
    }else if(staff.imageURL==null){
      return CircularProgressIndicator();
    }else{
      return Container(
        height:
        MediaQuery.of(context).size.height,
        width:
        MediaQuery.of(context).size.width,
        child: Image.network(
          staff.imageURL,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}
