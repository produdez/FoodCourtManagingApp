import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dish.dart';

class DishTile extends StatefulWidget {
  final Dish dish;
  DishTile({this.dish});
  @override
  _DishTileState createState() => _DishTileState();
}

class _DishTileState extends State<DishTile> {
  final db = Firestore.instance;

  void updateOrder(bool newValue) async {
    await db
        .collection('dishDB')
        .document(widget.dish.id)
        .updateData({'isOutOfOrder': newValue});
  }

  Future<bool> checkOrderStatus() async {
    DocumentSnapshot snapshot =
        await db.collection('dishDB').document(widget.dish.id).get();
    return snapshot.data['isOutOfOrder'];
  }

  //List<bool> isSelected = List.generate(1, (_) => true);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 400.0,
            //child: Image.asset(widget.imagePath, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 80.0,
              width: 400.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffff8a84), Colors.pink[100]],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.dish.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        FutureBuilder(
                            future: checkOrderStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                bool result = snapshot.data;
                                return Switch(
                                  value: result,
                                  onChanged: (bool newVal) {
                                    setState(() => result = newVal);
                                    updateOrder(newVal);
                                  },
                                  activeTrackColor: Colors.white,
                                  activeColor: Colors.white,
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                        // ToggleButtons(
                        //   children: <Widget>[
                        //     Icon(Icons.ac_unit),
                        //   ],
                        //   onPressed: (value) async {
                        //     await Firestore.instance
                        //         .collection('dishDB')
                        //         .document(widget.dish.id)
                        //         .updateData({'isOutOfOrder': true});
                        //     // setState(() {
                        //     //   for (int buttonIndex = 0;
                        //     //       buttonIndex < isSelected.length;
                        //     //       buttonIndex++) {
                        //     //     if (buttonIndex == index) {
                        //     //       isSelected[buttonIndex] = true;
                        //     //     } else {
                        //     //       isSelected[buttonIndex] = false;
                        //     //     }
                        //     //   }
                        //     // });
                        //   },
                        //   isSelected: isSelected,
                        // ),
                        // Switch(
                        //   value: isSwitched,
                        //   onChanged: (bool newValue) async {
                        //    await Firestore.instance
                        //         .collection('dishDB')
                        //         .document(widget.dish.id)
                        //         .updateData({'isOutOfOrder': });
                        //     setState(() {
                        //       isSwitched = value;
                        //       print(widget.dish.isOutOfOrder);
                        //     });
                        //   },
                        //   activeTrackColor: Colors.lightGreenAccent,
                        //   activeColor: Colors.green,
                        // ),
                      ],
                    ),
                  ],
                ),
                // Column(
                //   children: <Widget>[
                //     Text(
                //       widget.dish.realPrice.toString(),
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: Colors.orangeAccent,
                //         fontSize: 18.0,
                //       ),
                //     ),
                //     Text(
                //       "Price",
                //       style: TextStyle(
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
