class Dish {
  String id; // id is from database
  String name;
  double originPrice; //the original price before discount (not price) used in calculation
  double discountPercentage; //discount
  double realPrice; //real price due to discount

  //normal constructor
  Dish(this.name, this.originPrice, {this.discountPercentage = 0, this.realPrice, this.id = ""}) {
    if (this.realPrice == null) this.realPrice = this.originPrice;
  }

  //copy constructor
  Dish.clone(Dish dish) {
    this.name = dish.name;
    this.originPrice = dish.originPrice;
    this.id = dish.id;
    this.discountPercentage = dish.discountPercentage;
    this.realPrice = dish.realPrice;
  }
}
