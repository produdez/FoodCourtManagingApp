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
                    Text(
                      widget.phoneNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                'Finish',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xffff8a84),
                              onPressed: () {
                                _showDialog();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'Inform',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xffff8a84),
                              onPressed: () {
                                _showDialog1();
                              },
                            ),
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text("Order Finished"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog1() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text("Customer Informed"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
