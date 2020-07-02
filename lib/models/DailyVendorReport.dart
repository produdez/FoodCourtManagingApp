import 'dart:ffi';

class DailyVendorReport {
  String id; // id is from database
  String vendorId;
  String sale;
  String date;
  List<Order> orders;

  /*bool hasImage;
  File imageFile;*/
  //normal constructor
  //DailyVendorReport(this.id, this.vendorId, this.sale, this.date);
  DailyVendorReport(this.date, this.sale);

  DailyVendorReport.clone(DailyVendorReport dsreport) {
    this.id = dsreport.id;
    this.vendorId = dsreport.vendorId;
    this.sale = dsreport.sale;
    this.date = dsreport.date;
  }
}
class Order{
  String name;
  String price;
  String quantity;
  String revenue;
  Order(this.name, this.price, this.quantity, this.revenue);
}
