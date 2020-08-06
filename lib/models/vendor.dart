import 'dart:io';

class Vendor {
  String id;
  String name;
  String phone;
  String imageURL;

  bool hasImage;
  File imageFile;
  //Normal constructor
  Vendor(this.name, this.phone,
      {this.id = "", this.hasImage = false, this.imageFile, this.imageURL});

  @override
  String toString() {
    return 'Vendor{id: $id, name: $name, phone: $phone, imageURL: $imageURL, hasImage: $hasImage, imageFile: $imageFile}';
  } //Copy constructor

  Vendor.clone(Vendor vendor) {
    this.id = vendor.id;
    this.name = vendor.name;
    this.phone = vendor.phone;
    this.hasImage = vendor.hasImage;
    this.imageURL = vendor.imageURL;
  }
}
