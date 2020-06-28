import 'dart:io';

class Vendor {
  String id;
  String name;
  String phone;

  bool hasImage;
  File imageFile;
  //Normal constructor
  Vendor(this.name, this.phone, {this.id = "",this.hasImage=false,this.imageFile});

  //Copy constructor
  Vendor.clone(Vendor vendor) {
    this.id = vendor.id;
    this.name = vendor.name;
    this.phone = vendor.phone;
  }
}