class Order {
  final String id;
  final String phoneNumber;
  final String imagePath;
  final double totalPrice;

  Order({this.id, this.phoneNumber, this.imagePath, this.totalPrice});
}

final orders = [
  Order(
    id: "1",
    phoneNumber: "0932483127",
    imagePath: "assets/breakfast.jpeg",
    totalPrice: 20.0,
  ),
  Order(
    id: "2",
    phoneNumber: "0798654255",
    imagePath: "assets/lunch.jpeg",
    totalPrice: 40.0,
  ),
  Order(
    id: "3",
    phoneNumber: "0902248312",
    imagePath: "assets/supper_1.jpeg",
    totalPrice: 50.0,
  ),
  Order(
    id: "4",
    phoneNumber: "0284831273",
    imagePath: "assets/6.jpg",
    totalPrice: 30.0,
  ),
];
