import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/staff.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffDBService {
  //Collection reference for StaffDB
  final CollectionReference staffDB = Firestore.instance.collection("staffDB");

  //the staff db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  static String ownerID;
  static String vendorID;
  //add staff as a new document to db, id is randomize by Firebase
  Future addStaff(Staff staff) async {
    DocumentReference _staffRef = staffDB.document();
    ImageUploadService().uploadPic(staff.imageFile,_staffRef);
    return await _staffRef.setData({
      "name": staff.name,
      "id": _staffRef.documentID,
      "vendorID": ownerID,
      "phone" : staff.phone,
      "position" : staff.position,
      "hasImage" : staff.hasImage,
      "hasAccount" : false,
    });
  }

  //update staff, changing name, original price and reset it's discount state
  Future editStaff(Staff staff, Staff newStaff) async {
    DocumentReference _staffRef = staffDB.document(staff.id);
    ImageUploadService().uploadPic(newStaff.imageFile,_staffRef);
    return await _staffRef.updateData({
      "name": newStaff.name,
      "phone":newStaff.phone,
      "position" : newStaff.position,
      "hasImage" : newStaff.hasImage? newStaff.hasImage : staff.hasImage,
      //no update vendor ID
    });
  }

  //remove document from database collection
  Future removeStaff(Staff staff) async {
    DocumentReference _staffRef = staffDB.document(staff.id);
    ImageUploadService().removeImageFromStorage(staff.id);
    return await _staffRef.delete();
  }

  void callStaff(Staff staff){
    launch("tel://${staff.phone}");
    print('Calling: ${staff.phone}');
  }


  //get StaffDB snapshot stream, this stream will auto-update if DB have change and notify any listener
  Stream<List<Staff>> get allStaffsOfOwner {
    return staffDB.snapshots().map(_staffListFromSnapshot);
  }

  //Mapping a database snapshot into a staffList, but only staffs of the user (vendor) that's currently logged in
  List<Staff> _staffListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
    documentSnapshot.data['vendorID'] == ownerID)
        .map((doc) {
      return Staff(
        doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        phone: doc.data['phone'] ?? '',
        position: doc.data['position'] ?? '',
        hasImage: doc.data['hasImage'] ?? false,
        imageURL: doc.data['imageURL'] ?? null,
      );
    }).toList();
  }

  Future<bool> canCreateStaffAccount(String id) async {
    bool available = false;
    try {
      DocumentSnapshot staffSnapshot = await staffDB.document(id).get();
      if(staffSnapshot.exists){
        bool hasAccount = staffSnapshot.data['hasAccount']??false;
        available = !hasAccount;
      }
      return available;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future linkAccount(String staffId, String userId) async {
    DocumentReference _staffRef = staffDB.document(staffId);
    return await _staffRef.updateData({
      'hasAccount' : true,
      'accountID' : userId,
      //no update vendor ID
    });
  }

  Future<Staff> staffInfoFromAccountId(String accountID) async{
    Staff staffInfo;
    await staffDB.where("accountID", isEqualTo: accountID).getDocuments().then((value){
      value.documents.forEach((doc) {
        staffInfo = Staff(
          doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          phone: doc.data['phone'] ?? '',
          position: doc.data['position'] ?? '',
          hasImage: doc.data['hasImage'] ?? false,
          imageURL: doc.data['imageURL'] ?? null,
        );
      });
    });
    return staffInfo;
  }
// return vendorId of staff
  Future<bool> setStaffVendorId(String databaseID) async{
    //String vendorId;
    await staffDB.document(databaseID).get().then((value){
      vendorID = value.data['vendorID'];
    });
    return true;
  }
}


