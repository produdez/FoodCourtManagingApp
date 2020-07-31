import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dish.dart';
import 'dish_tile.dart';

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  @override
  Widget build(BuildContext context) {
    final dishes = Provider.of<List<Dish>>(context) ?? [];

    return ListView.builder(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        return DishTile(dish: dishes[index]);
      },
    );
  }
}
