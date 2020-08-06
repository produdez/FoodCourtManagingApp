import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/order.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:fcfoodcourt/models/user.dart';

class CartService {
  //Collection reference for DishDB
  final CollectionReference dishDB = Firestore.instance.collection("orderDB");

  //the dish db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  static List<Order> cart = [];
  static String orderID;
  static double totalPrice = 0;

  //add dish as a new document to db, id is randomize by Firebase
  /*Future addOrder(Order order) async {
    DocumentReference _orderRef = orderDB.document();
    return await _orderRef.setData({
      "id": _orderRef.documentID,
      "totalPrice": order.totalPrice,
    });
  }*/
  void addFromCart(OrderedDish dish) {
    dish.quantity++;
    dish.revenue += dish.price;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].vendorID == dish.vendorID) {
        cart[i].totalPrice += dish.price;
      }
    }
    totalPrice += dish.price;
  }

  void addDish(Dish dish, String vendorName) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].vendorID == dish.vendorID) {
        for (int j = 0; j < cart[i].detail.length; j++) {
          if (cart[i].detail[j].dishID == dish.id) {
            cart[i].detail[j].quantity++;
            cart[i].detail[j].revenue += dish.realPrice;
            cart[i].totalPrice += dish.realPrice;
            totalPrice += dish.realPrice;
            return;
          }
        }
        OrderedDish addedDish = OrderedDish(
            name: dish.name,
            price: dish.realPrice,
            quantity: 1,
            revenue: dish.realPrice,
            dishID: dish.id,
            vendorID: dish.vendorID);
        cart[i].detail.add(addedDish);
        cart[i].totalPrice += dish.realPrice;
        totalPrice += dish.realPrice;
        return;
      }
    }
    Order newOrder = Order(
        totalPrice: dish.realPrice,
        vendorID: dish.vendorID,
        vendorName: vendorName);
    OrderedDish addedDish = OrderedDish(
        name: dish.name,
        price: dish.realPrice,
        quantity: 1,
        revenue: dish.realPrice,
        dishID: dish.id,
        vendorID: dish.vendorID);
    newOrder.detail.add(addedDish);
    cart.add(newOrder);
    totalPrice += dish.realPrice;
  }

  void removeDish(OrderedDish dish) {
    for (int j = 0; j < cart.length; j++) {
      if (cart[j].vendorID == dish.vendorID) {
        for (int i = 0; i < cart[j].detail.length; i++) {
          if (cart[j].detail[i].dishID == dish.dishID) {
            totalPrice -= dish.revenue;
            cart[j].totalPrice -= dish.revenue;
            cart[j].detail.removeAt(i);
            if (cart[j].totalPrice == 0) cart.removeAt(j);
            return;
          }
        }
      }
    }
  }

  void reduceDish(OrderedDish dish) {
    for (int j = 0; j < cart.length; j++) {
      if (cart[j].vendorID == dish.vendorID) {
        cart[j].totalPrice -= dish.price;
        totalPrice -= dish.price;
        dish.quantity--;
        dish.revenue -= dish.price;
        // for (int i = 0; i < order.detail.length; i++) {
        //   if (order.detail[i].dishID == dish.dishID) {

        //     order.detail[i].revenue -= dish.price;
        //     order.totalPrice -= dish.price;
        //     totalPrice -= dish.price;
        //     return;
        //   }
        // }
      }
    }
  }

  // void toInitCart() {
  //   CartService.initTotal = CartService.totalPrice;
  //   for (int i = 0; i < CartService.cart.length; i++) {
  //     Order initOrder = Order(
  //         totalPrice: CartService.cart[i].totalPrice,
  //         vendorID: CartService.cart[i].vendorID,
  //         vendorName: CartService.cart[i].vendorName);
  //     for (int j = 0; j < CartService.cart[i].detail.length; j++) {
  //       OrderedDish initDish = OrderedDish(
  //           name: CartService.cart[i].detail[j].name,
  //           price: CartService.cart[i].detail[j].price,
  //           quantity: CartService.cart[i].detail[j].quantity,
  //           revenue: CartService.cart[i].detail[j].revenue,
  //           dishID: CartService.cart[i].detail[j].dishID,
  //           vendorID: CartService.cart[i].detail[j].vendorID);
  //       initOrder.detail.add(initDish);
  //     }
  //     CartService.initCart.add(initOrder);
  //   }
  // }
}
