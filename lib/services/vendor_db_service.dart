  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:fcfoodcourt/models/vendor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_upload_service.dart';
  
class VendorDBService{

  final CollectionReference vendorDB = Firestore.instance.collection("vendorDB");

  Future addVendor(Vendor vendor) async {
    DocumentReference _vendorRef = vendorDB.document();
    ImageUploadService().uploadPic(vendor.imageFile,_vendorRef.documentID);
    return await _vendorRef.setData({
      "id": _vendorRef.documentID,
      "name": vendor.name,
      "phone": vendor.phone,
      "hasImage" : vendor.hasImage,
    });
  }
  Future editVendor(Vendor vendor, Vendor newVendor) async {
    DocumentReference _staffRef = vendorDB.document(vendor.id);
    ImageUploadService().uploadPic(vendor.imageFile,_staffRef.documentID);
    return await _staffRef.updateData({
      "name": newVendor.name,
      "phone":newVendor.phone,
      "hasImage" : vendor.hasImage==true?true:newVendor.hasImage==true?true:false,
      //no update vendor ID
    });
  }

  Future removeVendor(Vendor vendor) async {
    DocumentReference _staffRef = vendorDB.document(vendor.id);
    ImageUploadService().removeImageFromStorage(vendor.id);
    return await _staffRef.delete();
  }

  void callVendor(Vendor vendor){
    launch("tel://${vendor.phone}");
    print('Calling: ${vendor.phone}');
  }

  void populateDatabaseRandom() {
    VendorDBService dbService = new VendorDBService();
    dbService.addVendor(Vendor("Vendor1", "0123456789"));
    dbService.addVendor(Vendor("Vendor2", "0123456788"));
    dbService.addVendor(Vendor("Vendor3", "0123456787"));
    dbService.addVendor(Vendor("Vendor4", "0123456786"));
    dbService.addVendor(Vendor("Vendor5", "0123456785"));
    dbService.addVendor(Vendor("Vendor6", "0123456784"));
    dbService.addVendor(Vendor("Vendor7", "0123456783"));
    dbService.addVendor(Vendor("Vendor8", "0123456782"));
  }

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
        hasImage: doc.data['hasImage'] ?? false,
      );
    }).toList();
  }
}