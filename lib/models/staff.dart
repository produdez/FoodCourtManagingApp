
import 'dart:io';

class Staff{
  String id;
  String name;
  String ownerID;
  String phone;
  String position;


  bool hasImage;
  File imageFile;

  Staff(this.name,{this.id= "", this.ownerID ="", this.phone ="", this.position = "", this.hasImage = false,this.imageFile});

  Staff.clone(Staff staff){
    this.id = staff.id;
    this.ownerID = staff.ownerID;
    this.name = staff.name;
    this.phone = staff.phone;
    this.hasImage = this.hasImage;
  }
}