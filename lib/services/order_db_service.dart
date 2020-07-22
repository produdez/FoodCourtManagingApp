import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/order.dart';

class OrderDBService {
  //Collection reference for DishDB
  final CollectionReference orderDB = Firestore.instance.collection("orderDB");

  //the dish db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  Future createOrder(List<Order> cart) async {
    for (int i = 0; i < cart.length; i++) {
      DocumentReference _orderRef = orderDB.document();
      cart[i].id = _orderRef.documentID;
      await _orderRef.setData({
        "customerID": Order.customerID,
        "totalPrice": '${cart[i].totalPrice}',
        "vendorID": cart[i].vendorID,
      });
      for (int j = 0; j < cart[i].detail.length; j++) {
        await orderDB
            .document(cart[i].id)
            .collection("detail")
            .document()
            .setData({
          "name": cart[i].detail[j].name,
          "price": cart[i].detail[j].price.toString(),
          "quantity": cart[i].detail[j].quantity,
          "revenue": cart[i].detail[j].revenue.toString()
        });
      }
    }
  }
}
