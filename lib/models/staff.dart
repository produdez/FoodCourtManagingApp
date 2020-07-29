
import 'dart:io';

class Staff{
  String id;
  String name;
  String ownerID;
  String phone;
  String position;
  String imageURL;

  bool hasImage;
  File imageFile;

  Staff(this.name,{this.id= "", this.ownerID ="", this.phone ="", this.position = "", this.hasImage = false,this.imageFile, this.imageURL});

  Staff.clone(Staff staff){
    this.id = staff.id;
    this.ownerID = staff.ownerID;
    this.name = staff.name;
    this.phone = staff.phone;
    this.hasImage = staff.hasImage;
    this.imageURL = staff.imageURL;
  }

  @override
  String toString() {
    return 'Staff{id: $id, name: $name, ownerID: $ownerID, phone: $phone, position: $position, imageURL: $imageURL, hasImage: $hasImage, imageFile: $imageFile}';
  }
}