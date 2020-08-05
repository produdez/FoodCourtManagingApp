import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:fcfoodcourt/services/search_service.dart';

class DishDBService {
  //Collection reference for DishDB
  static final CollectionReference dishDB =
      Firestore.instance.collection("dishDB");

  //the dish db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  static String vendorID = 'fakeVendorID';

  //add dish as a new document to db, id is randomize by Firebase
  Future addDish(Dish dish) async {
    DocumentReference _dishRef = dishDB.document();
    ImageUploadService().uploadPic(dish.imageFile, _dishRef);
    return await _dishRef.setData({
      "name": dish.name,
      "id": _dishRef.documentID,
      "originPrice": dish.originPrice,
      "realPrice": dish.realPrice,
      "discountPercentage": dish.discountPercentage,
      "vendorID": vendorID,
      "hasImage": dish.hasImage,
      "isOutOfOrder": dish.isOutOfOrder,
    });
  }

  //update dish, changing name, original price and reset it's discount state
  Future editDish(Dish dish, Dish newDish) async {
    DocumentReference _dishRef = dishDB.document(dish.id);
    ImageUploadService().uploadPic(newDish.imageFile, _dishRef);
    return await _dishRef.updateData({
      "name": newDish.name,
      "originPrice": newDish.originPrice,
      "realPrice": newDish.originPrice, //reset on edit
      "discountPercentage": 0.0, //reset on edit
      "hasImage": newDish.hasImage ? newDish.hasImage : dish.hasImage,
      "isOutOfOrder": false, // reset on edit
      //no update vendor ID
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
    ImageUploadService().removeImageFromStorage(dish.id);
    return await _dishRef.delete();
  }

  //set Dish out of order
  Future setOutOfOrder(Dish dish) async {
    DocumentReference _dishRef = dishDB.document(dish.id);
    return await _dishRef.updateData({
      "isOutOfOrder": dish.isOutOfOrder, //this data is set in the dish above
      //no update vendor ID
    });
  }

  //get DishDB snapshot stream, this stream will auto-update if DB have change and notify any listener
  Stream<List<Dish>> get allVendorDishes {
    return dishDB.snapshots().map(_dishListFromSnapshot);
  }

  //Mapping a database snapshot into a dishList, but only dishes of the user (vendor) that's currently logged in
  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    if (filter == 0) {
      return snapshot.documents
          .where((DocumentSnapshot documentSnapshot) =>
              documentSnapshot.data['vendorID'] == vendorID)
          .map((doc) {
        return Dish(
          doc.data['name'] ?? '',
          doc.data['originPrice'].toDouble() ?? 0.0,
          discountPercentage: doc.data['discountPercentage'] ?? 0.0,
          realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
          id: doc.data['id'] ?? '',
          vendorID: doc.data['vendorID'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      }).toList();
    } else if (filter == 1) {
      return snapshot.documents
          .where((DocumentSnapshot documentSnapshot) =>
              documentSnapshot.data['vendorID'] == vendorID &&
              documentSnapshot.data['realPrice'].toDouble() < 30000)
          .map((doc) {
        return Dish(
          doc.data['name'] ?? '',
          doc.data['originPrice'].toDouble() ?? 0.0,
          discountPercentage: doc.data['discountPercentage'] ?? 0.0,
          realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
          id: doc.data['id'] ?? '',
          vendorID: doc.data['vendorID'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      }).toList();
    } else if (filter == 2) {
      return snapshot.documents
          .where((DocumentSnapshot documentSnapshot) =>
              documentSnapshot.data['vendorID'] == vendorID &&
              documentSnapshot.data['realPrice'].toDouble() <= 50000 &&
              documentSnapshot.data['realPrice'].toDouble() >= 30000)
          .map((doc) {
        return Dish(
          doc.data['name'] ?? '',
          doc.data['originPrice'].toDouble() ?? 0.0,
          discountPercentage: doc.data['discountPercentage'] ?? 0.0,
          realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
          id: doc.data['id'] ?? '',
          vendorID: doc.data['vendorID'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      }).toList();
    } else if (filter == 3) {
      return snapshot.documents
          .where((DocumentSnapshot documentSnapshot) =>
              documentSnapshot.data['vendorID'] == vendorID &&
              documentSnapshot.data['realPrice'].toDouble() >= 50000)
          .map((doc) {
        return Dish(
          doc.data['name'] ?? '',
          doc.data['originPrice'].toDouble() ?? 0.0,
          discountPercentage: doc.data['discountPercentage'] ?? 0.0,
          realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
          id: doc.data['id'] ?? '',
          vendorID: doc.data['vendorID'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      }).toList();
    }
  }
}
