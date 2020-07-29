import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/vendor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_upload_service.dart';

class VendorDBService {
  final CollectionReference vendorDB =
      Firestore.instance.collection("vendorDB");

  Future addVendor(Vendor vendor) async {
    DocumentReference _vendorRef = vendorDB.document();
    ImageUploadService().uploadPic(vendor.imageFile, _vendorRef);
    return await _vendorRef.setData({
      "id": _vendorRef.documentID,
      "name": vendor.name,
      "phone": vendor.phone,
      "hasImage": vendor.hasImage,
    });
  }

  Future editVendor(Vendor vendor, Vendor newVendor) async {
    DocumentReference _staffRef = vendorDB.document(vendor.id);
    ImageUploadService().uploadPic(newVendor.imageFile, _staffRef);
    return await _staffRef.updateData({
      "name": newVendor.name,
      "phone": newVendor.phone,
      "hasImage": newVendor.hasImage ? newVendor.hasImage : vendor.hasImage,
      //no update vendor ID
    });
  }

  Future removeVendor(Vendor vendor) async {
    DocumentReference _staffRef = vendorDB.document(vendor.id);
    ImageUploadService().removeImageFromStorage(vendor.id);
    return await _staffRef.delete();
  }

  void callVendor(Vendor vendor) {
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
    return snapshot.documents.map((doc) {
      return Vendor(
        doc.data['name'] ?? '',
        doc.data['phone'] ?? '',
        id: doc.data['id'] ?? '',
        hasImage: doc.data['hasImage'] ?? false,
        imageURL: doc.data['imageURL'] ?? null,
      );
    }).toList();
  }

  Future<String> nameOfVendor(String vendorID, String vendorName) async {
    await vendorDB.getDocuments().then((snapshot) async {
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data['id'] == vendorID) {
          vendorName = snapshot.documents[i].data['name'];
        }
      }
    });
    print('hi $vendorName');
    return vendorName.toString();
  }

  void vname(String vendorID, String vname) async {
    vname = await nameOfVendor(vendorID, vname);
    print('hello $vname');
  }

  Future<bool> canCreateVendorAccount(String id) async {
    bool available = false;
    try {
      DocumentSnapshot staffSnapshot = await vendorDB.document(id).get();
      if (staffSnapshot.exists) {
        bool hasAccount = staffSnapshot.data['hasAccount'] ?? false;
        available = !hasAccount;
      }
      return available;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future linkAccount(String vendorID, String userId) async {
    DocumentReference _vendorRef = vendorDB.document(vendorID);
    return await _vendorRef.updateData({
      'hasAccount': true,
      'accountID': userId,
      //no update vendor ID
    });
  }

  Future<Vendor> vendorInfoFromAccountId(String accountID) async {
    Vendor vendorInfo;
    await vendorDB
        .where("accountID", isEqualTo: accountID)
        .getDocuments()
        .then((value) {
      value.documents.forEach((doc) {
        vendorInfo = Vendor(
          doc.data['name'] ?? '',
          doc.data['phone'] ?? '',
          id: doc.data['id'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      });
    });
    return vendorInfo;
  }
}
