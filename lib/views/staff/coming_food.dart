import 'package:flutter/material.dart';

class ComingOrder extends StatefulWidget {
  final String id;
  final String phoneNumber;
  final String imagePath;
  final double totalPrice;

  ComingOrder({this.id, this.phoneNumber, this.imagePath, this.totalPrice});

  @override
  _ComingOrderState createState() => _ComingOrderState();
}

class _ComingOrderState extends State<ComingOrder> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 400.0,
            child: Image.asset(widget.imagePath, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 80.0,
              width: 400.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 0.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Text(
                      widget.phoneNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    Row(
                      children: <Widget>[
                        ButtonBar(
                          children: <Widget>[
                            ToggleButtons(
                              children: [Icon(Icons.check_circle_outline)],
                              isSelected: _selections,
                              onPressed: (int index) {
                                setState(() {
                                  _selections[index] = !_selections[index];
                                });
                              },
                              color: Colors.white, //Color(0xffff8a84),
                              fillColor: Color(0xffff8a84),
                              selectedColor: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      widget.totalPrice.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Total Price",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<bool> _selections = List.generate(1, (_) => true);
}
