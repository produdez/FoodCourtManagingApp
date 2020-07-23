//import 'dart:js';
//import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
//import 'package:fcfoodcourt/services/order_db_service.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/services/dish_db_service.dart';
import 'package:fcfoodcourt/views/customer/Menu/search_view.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:';
class SearchService extends SearchDelegate<String> {
  //DishDBService dishDBService;
  // Stream<List<Dish>> get passToArray {
  //   return dishDB.snapshots().map(_dishListFromSnapshot);
  // }

  // // //Mapping a database snapshot into a dishList, but only dishes of the user (vendor) that's currently logged in
  // List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Dish(
  //       doc.data['name'] ?? '',
  //       doc.data['originPrice'] ?? 0.0,
  //       discountPercentage: doc.data['discountPercentage'] ?? 0.0,
  //       realPrice: doc.data['realPrice'] ?? 0.0,
  //       id: doc.data['id'] ?? '',
  //       hasImage: doc.data['hasImage'] ?? false,
  //       isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
  //     );
  //   }).toList();
  // }

  Future<void> passToArray() async {
    await dishDB.getDocuments().then((snapshot) async {
      for (int i = 0; i < snapshot.documents.length; i++) {
        SearchItem.suggestion.add(SearchItem(snapshot.documents[i].data['name'],
            snapshot.documents[i].data['vendorID']));
        //vID.add(snapshot.documents[i].data['vendorID']);
        //print(suggestion[i]);
        //print(vID[i]);
      }
    });
    return null;
  }

  CollectionReference dishDB = Firestore.instance.collection("dishDB");
  //CollectionReference vendorDB = Firestore.instance.collection("vendorDB");
  String cIndex = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          SearchItem.suggestion = [];
          //vID = [];
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty == true) {
      final suggestionList = SearchItem.history.reversed.toList();
      return ListView.builder(
        //itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            cIndex = suggestionList[index].vendorID;
            SearchItem.history.add(SearchItem(
                suggestionList[index].name, suggestionList[index].vendorID));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchView(
                          cIndex,
                        )));
          },
          leading: Icon(Icons.history),
          title: Text(suggestionList[index].name),
        ),
        itemCount: suggestionList.length,
      );
    } else {
      final suggestionList = SearchItem.suggestion
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return ListView.builder(
        //itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            cIndex = suggestionList[index].vendorID;
            SearchItem.history.add(SearchItem(
                suggestionList[index].name, suggestionList[index].vendorID));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchView(cIndex)));
          },
          leading: Icon(Icons.search),
          title: Text(suggestionList[index].name),
        ),
        itemCount: suggestionList.length,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //final suggestionList = query.isEmpty
    if (query.isEmpty == true) {
      final suggestionList = SearchItem.history.reversed.toList();
      return ListView.builder(
        //itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            cIndex = suggestionList[index].vendorID;
            SearchItem.history.add(SearchItem(
                suggestionList[index].name, suggestionList[index].vendorID));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchView(cIndex)));
          },
          leading: Icon(Icons.history),
          title: Text(suggestionList[index].name),
        ),
        itemCount: suggestionList.length,
      );
    } else {
      final suggestionList = SearchItem.suggestion
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return ListView.builder(
        //itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            cIndex = suggestionList[index].vendorID;
            SearchItem.history.add(SearchItem(
                suggestionList[index].name, suggestionList[index].vendorID));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchView(cIndex)));
          },
          leading: Icon(Icons.search),
          title: Text(suggestionList[index].name),
        ),
        itemCount: suggestionList.length,
      );
    }

    // return StreamBuilder(
    //     stream: Firestore.instance.collection('dishDB').snapshots(),
    //     builder: (context, snapshot) {
    //       final results = snapshot.data.documents.where((DocumentSnapshot a) =>
    //           a.data['name'].toString().contains(query));
    //       return ListView.builder(
    //         itemBuilder: (context, index) => ListTile(
    //           onTap: () {
    //             showResults(context);
    //           },
    //           leading: Icon(Icons.location_city),
    //           title: Text(results[index]),
    //         ),
    //         itemCount: results.length,
    //       );

    //       // children: results
    //       //     .map<Widget>((a) => Text(a.data['name'].toString()))
    //       //     .toList(),
    //     });
    //   List<Dish> items = [
    //     Dish('apple', 120909),
    //     Dish('basd', 120909),
    //     Dish('orange', 120909),
    //     Dish('banana', 120909),
    //     Dish('pear', 120909),
    //     Dish('apple', 120909),
    //   ];

    //   List<Dish> suggestionList = query.isEmpty
    //       ? searchByName
    //       : items.where((element) => element.name.contains(query)).toList();
    //   return suggestionList.isEmpty
    //       ? Text("no result found")
    //       : ListView.builder(
    //           itemBuilder: (context, index) {
    //             return ListTile(
    //               title: Text(suggestionList[index].name),
    //               onTap: () {
    //                 showResults(context);
    //               },
    //             );
    //           },
    //           itemCount: suggestionList.length,
    //         );
    // }
  }

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';

class SearchService {
  //Collection reference for DishDB
  final CollectionReference dishDB = Firestore.instance.collection("dishDB");

  //the dish db only response the correct menu according to the user's id (vendor's id)
  //this field is static and set when we first go to home page (menu,... in this case)
  //static String vendorID = 'fakeVendorID';
  static String keyword = "";
  Stream<List<Dish>> get searchByName {
    return dishDB.snapshots().map(_dishListFromSnapshot);
  }

  //Mapping a database snapshot into a dishList, but only dishes of the user (vendor) that's currently logged in
  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['name'].contains(keyword))
        .map((doc) {
      return Dish(
        doc.data['name'] ?? '',
        doc.data['originPrice'] ?? 0.0,
        discountPercentage: doc.data['discountPercentage'] ?? 0.0,
        realPrice: doc.data['realPrice'] ?? 0.0,
        id: doc.data['id'] ?? '',
        hasImage: doc.data['hasImage'] ?? false,
        isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
      );
    }).toList();
  }
}*/

}
