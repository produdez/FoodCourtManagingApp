import 'package:cloud_firestore/cloud_firestore.dart';
import '../../views/staff/Dish/dish.dart';

class DishDBServices {
  static String vendorID;
  final CollectionReference dishCollection =
      Firestore.instance.collection('dishDB');

  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['vendorID'] == vendorID)
        .map((doc) {
      return Dish(
        name: doc.data['name'] ?? '',
        //realPrice: double.tryParse(doc.data['realPrice']) ?? 0.0,
        isOutOfOrder: doc.data['isOutOfOrder'] ?? '',
        id: doc.data['id'] ?? '',
      );
    }).toList();
  }

  Stream<List<Dish>> get dishes {
    return dishCollection.snapshots().map(_dishListFromSnapshot);
  }
}
