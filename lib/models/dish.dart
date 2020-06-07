

class Dish {
  int id;
  String name;
  double originPrice;
  double discountPercentage;
  double realPrice; //real price due to discount


  Dish(this.name, this.originPrice, {this.discountPercentage = 0,this.realPrice,this.id=-1}){
    if(this.realPrice == null)this.realPrice = this.originPrice;
  }
  Dish.clone(Dish dish){
    this.name = dish.name;
    this.originPrice = dish.originPrice;
    this.id = dish.id;
    this.discountPercentage = dish.discountPercentage;
    this.realPrice = dish.realPrice;
  }
}