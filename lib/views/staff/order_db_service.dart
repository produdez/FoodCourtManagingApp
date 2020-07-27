import 'package:cloud_firestore/cloud_firestore.dart';
import 'order.dart';

class OrderDBService {
  static String vendorID;
  static List<OrderedDish> detail = [];
  final CollectionReference orderCollection =
      Firestore.instance.collection('orderDB');

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        // .where((DocumentSnapshot documentSnapshot) =>
        //     documentSnapshot.data['vendorID'] == vendorID)
        .map((doc) {
      return Order(
        customerID: doc.data['customerID'] ?? '',
        totalPrice: double.tryParse(doc.data['totalPrice']) ?? 0.0,
        id: doc.data['id'] ?? '',
      );
    }).toList();
  }

  List<String> _orderIdListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['customerID'] == customerID &&
            documentSnapshot.data['inform'] == true)
        .map((doc) {
      return doc.data['vendorID'];
    });
  }

  Stream<List<String>> get orderId {
    return orderCollection.snapshots().map(_orderIdListFromSnapshot);
  }

  Stream<List<Order>> get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Future<List<OrderedDish>> viewOrderedDish(String time) async {
    List<OrderedDish> orderedDish;
    await _orderedDishesFromSnapshot(time).then((onValue) {
      if (onValue != null) orderedDish = onValue;
    }).catchError((onError) {
      return null;
    });
    return orderedDish;
  }

  Future<List<OrderedDish>> _orderedDishesFromSnapshot(String orderId) async {
    //print(orderId);
    List<OrderedDish> orderedDish;
    int i;
    await orderCollection.getDocuments().then((snapshot) async {
      for (i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].documentID == orderId) {
          await orderCollection
              .document(snapshot.documents[i].documentID.toString())
              .collection("detail")
              .getDocuments()
              .then(_createListofDishes);
          orderedDish = detail;
          //print(detail.length);
          break;
        }
      }
    });
    return orderedDish;
  }

  _createListofDishes(QuerySnapshot querySnapshot) {
    var docs = querySnapshot.documents;
    //print(docs.length);
    detail.clear();
    for (DocumentSnapshot doc in docs) {
      //print(doc.data['name']);
      detail.add(OrderedDish.fromFireBase(doc));
      // print(detail.length);
    }
  }
}
