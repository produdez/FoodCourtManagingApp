import 'package:fcfoodcourt/models/orderedDish.dart';

// class OrderedDish {
//   String dishID;
//   String name;
//   double price;
//   int quantity;
//   double revenue;
//   OrderedDish({this.name, this.price, this.quantity, this.revenue});
//   factory OrderedDish.fromFireBase(DocumentSnapshot doc) {
//     return OrderedDish(
//       name: doc.data['name'],
//       quantity: doc.data['quantity'],
//     );
//   }
// }

// this class is not for the whole order of the customer
// instead, it is just the ordered dishes associated with each vendor
class Order {
  final String id;
  final String customerID;
  String vendorID;
  String vendorName;
  String phoneNumber;
  double totalPrice;
  bool inform;
  //String imagePath;
  List<OrderedDish> detail = [];
  Order({
    this.customerID,
    this.totalPrice,
    this.id,
    this.vendorID,
    this.vendorName,
    this.inform,
    this.phoneNumber,
    //this.imagePath = 'assets/breakfast.jpeg',
  });
}

/*factory Order.fromFireBase(DocumentSnapshot doc) {
    Map data = doc.data;

    return Order(
        id: data['id'],
        totalPrice: double.tryParse(data['price']),
        
        vendorID: data['vendorID']
        );
  }*/
