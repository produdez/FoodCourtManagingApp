  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:fcfoodcourt/models/vendor.dart';
  
class VendorDBService{
  final CollectionReference vendorDB = Firestore.instance.collection("vendorDB");
  //get VendorDB snapshot stream, this stream will auto-update if DB have change and notify any listenener
  Stream<List<Vendor>> get allVendor {
    return vendorDB.snapshots().map(_vendorListFromSnapshot);
  }

  //Mapping a database snapshot into a vendorList
  List<Vendor> _vendorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) {
      return Vendor(
        doc.data['name'] ?? '',
        doc.data['phone'] ?? '',
        id: doc.data['id'] ?? '',
        //TODO: will add vendor id later after implementing log-in
        //dish.vendorID = ...;
      );
    }).toList();
  }
}