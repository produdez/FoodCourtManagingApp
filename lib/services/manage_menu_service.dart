
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/local_menu_data.dart';

class ManageMenuService{
  LocalMenuData dataConnection = new LocalMenuData(); //data base reference
  List<Dish> getMenuDishList() => dataConnection.getMenu();
  void newDish(Dish dish){
    dataConnection.add(dish);
  }
  void removeDish(Dish dish){
    dataConnection.remove(dish);
  }
  void editDish(Dish dish, Dish newDishInfo){ //newDishInfo is just a empty dish that holds some attributes that changed like name,price
    //make a clone of the old dish
    Dish newDish = Dish.clone(dish);
    //change some attributes
    newDish.name = newDishInfo.name;
    newDish.originPrice = newDishInfo.originPrice;
    newDish.discountPercentage=0;
    newDish.realPrice = newDish.originPrice;
    //replace that into the database
    dataConnection.editDish(dish, newDish);
  }
  void discountDish(Dish dish, Dish discountInfo){
    //make clone of old dish
    Dish newDish = Dish.clone(dish);
    //Change the discount attributes
    newDish.realPrice = discountInfo.realPrice;
    newDish.discountPercentage = discountInfo.discountPercentage;
    //replace that into database
    dataConnection.editDish(dish, newDish);
  }
  void populateMenuRandom(){
    dataConnection.add(new Dish('French Fries', 30));
    dataConnection.add(new Dish('Omelet', 12));
    dataConnection.add(new Dish('Salad', 50));
    dataConnection.add(new Dish('Rice', 30));
    dataConnection.add(new Dish('Tomato Juice', 80));
    dataConnection.add(new Dish('Bacon', 15));
    dataConnection.add(new Dish('Soup', 70));
    dataConnection.add(new Dish('Water', 30));
    dataConnection.add(new Dish('Buffet', 99));
    dataConnection.add(new Dish('Chicken', 55));
    dataConnection.add(new Dish('U mom', 100));
  }
}