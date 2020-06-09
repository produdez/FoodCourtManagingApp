import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';

//TODO: after implementing login, the vendorID of DishDBService should be set to the user's id before attempting to load and show dish list

class DishDBService {
  //the dish db only response the correct menu according to the user's id (vendor's id)
  final String vendorID =
      "fakeVendorID"; //vendor is not implemented, we're assuming a fake vendor user id

  //Collection reference for DishDB
  final CollectionReference dishDB = Firestore.instance.collection("dishDB");

  //add dish as a new document to db, id is randomize by Firebase
  Future addDish(Dish dish) async {
    DocumentReference _dishRef = dishDB.document();
    return await _dishRef.setData({
      "name": dish.name,
      "id": _dishRef.documentID,
      "originPrice": dish.originPrice,
      "realPrice": dish.realPrice,
      "discountPercentage": dish.discountPercentage,
      "vendorID": vendorID,
    });
  }

  //update dish, changing name, original price and reset it's discount state
  Future editDish(Dish dish, Dish newDish) async {
    DocumentReference _dishRef = dishDB.document(dish.id);
    return await _dishRef.updateData({
      "name": newDish.name,
      "originPrice": newDish.originPrice,
      "realPrice": newDish.originPrice,
      "discountPercentage": 0.0,
    });
  }

  //update discount prices
  Future discountDish(Dish dish, Dish newDish) async {
    DocumentReference _dishRef = dishDB.document(dish.id);
    return await _dishRef.updateData({
      "realPrice": newDish.realPrice,
      "discountPercentage": newDish.discountPercentage,
    });
  }

  //remove document from database collection
  Future removeDish(Dish dish) async {
    DocumentReference _dishRef = dishDB.document(dish.id);
    return await _dishRef.delete();
  }

  //a fake data if needed
  void populateDatabaseRandom() {
    DishDBService dbService = new DishDBService();
    dbService.addDish(Dish("Dish1", 30));
    dbService.addDish(Dish("Dish2", 40));
    dbService.addDish(Dish("Dish3", 50));
    dbService.addDish(Dish("Dish4", 60));
    dbService.addDish(Dish("Dish5", 70));
    dbService.addDish(Dish("Dish6", 80));
    dbService.addDish(Dish("Dish7", 90));
    dbService.addDish(Dish("Dish8", 100));
  }

  //get DishDB snapshot stream, this stream will auto-update if DB have change and notify any listener
  Stream<List<Dish>> get allVendorDishes {
    return dishDB.snapshots().map(_dishListFromSnapshot);
  }

  //Mapping a database snapshot into a dishList, but only dishes of the user (vendor) that's currently logged in
  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['vendorID'] == vendorID)
        .map((doc) {
      return Dish(
        doc.data['name'] ?? '', doc.data['originPrice'] ?? 0.0,
        discountPercentage: doc.data['discountPercentage'] ?? 0.0,
        realPrice: doc.data['realPrice'] ?? 0.0,
        id: doc.data['id'] ?? '',
        //TODO: will add vendor id later after implementing log-in
        //dish.vendorID = ...;
      );
    }).toList();
  }
}
