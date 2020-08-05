import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/order.dart';

import 'cart_service.dart';

class OrderDBService {
  final CollectionReference orderDB = Firestore.instance.collection("orderDB");
  static String customerID;
  //the dish db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  Future createOrder() async {
    for (int i = 0; i < CartService.cart.length; i++) {
      DocumentReference _orderRef = orderDB.document();
      CartService.cart[i].id = _orderRef.documentID;
      await _orderRef.setData({
        "customerID": customerID,
        "totalPrice": '${CartService.cart[i].totalPrice}',
        "vendorID": CartService.cart[i].vendorID,
        "inform": false,
        "vendorName": CartService.cart[i].vendorName
      });
      for (int j = 0; j < CartService.cart[i].detail.length; j++) {
        await orderDB
            .document(CartService.cart[i].id)
            .collection("detail")
            .document()
            .setData({
          "name": CartService.cart[i].detail[j].name,
          "price": CartService.cart[i].detail[j].price.toString(),
          "quantity": CartService.cart[i].detail[j].quantity,
          "revenue": CartService.cart[i].detail[j].revenue.toString()
        });
      }
    }
    CartService.cart.clear();
    CartService.totalPrice = 0;
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    //print(vendorID);
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['customerID'] == customerID)
        .map((doc) {
      return Order(
        vendorName: doc.data['vendorName'] ?? '',
        totalPrice: double.tryParse(doc.data['totalPrice']) ?? 0.0,
        inform: doc.data['inform'] ?? '',
      );
    }).toList();
  }

  Stream<List<Order>> get orders {
    return orderDB.snapshots().map(_orderListFromSnapshot);
  }
}
