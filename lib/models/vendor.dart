class Vendor {
  String id;
  String name;
  String phone;

  //Normal constructor
  Vendor(this.name, this.phone, {this.id = ""}) {}

  //Copy constructor
  Vendor.clone(Vendor vendor) {
    this.id = vendor.id;
    this.name = vendor.name;
    this.phone = vendor.phone;
  }
}