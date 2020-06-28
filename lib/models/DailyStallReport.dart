class DailyStallReport {
  String id; // id is from database
  String vendorId;
  double sale;
  String date;


  /*bool hasImage;
  File imageFile;*/
  //normal constructor
  DailyStallReport(this.id, this.vendorId, this.sale, this.date) {}

  DailyStallReport.clone(DailyStallReport dsreport) {
    this.id = dsreport.id;
    this.vendorId = dsreport.vendorId;
    this.sale = dsreport.sale;
    this.date = dsreport.date;
  }
}
