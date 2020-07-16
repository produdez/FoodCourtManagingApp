/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/services/image_upload_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:';

class Search extends SearchDelegate<Dish> {
  //final Bloc<
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //throw UnimplementedError();
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
    // TODO: implement buildLeading
    //throw UnimplementedError();
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //throw UnimplementedError();
    InheritedBlocs.of(context)
        .searchBloc
        .searchTerm
        .add(query);

    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc
        StreamBuilder(
          stream: InheritedBlocs.of(context).searchBloc.searchResults,
          builder: (context, AsyncSnapshot<List<Result>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var result = results[index];
                  return ListTile(
                    title: Text(result.title),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}

class InheritedBlocs extends InheritedWidget {
  InheritedBlocs({Key key, this.searchBloc, this.child})
      : super(key: key, child: child);

  final Widget child;
  final SearchBloc searchBloc;

  static InheritedBlocs of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedBlocs)
        as InheritedBlocs);
  }

  @override
  bool updateShouldNotify(InheritedBlocs oldWidget) {
    return true;
  }
}

class SearchBloc {
  String keyword;
  SearchBloc(this.keyword);
  final CollectionReference dishDB = Firestore.instance.collection("dishDB");
  Stream<List<Dish>> get allVendorDishes {
    return dishDB.snapshots().map(_dishListFromSnapshot);
  }

  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .where((DocumentSnapshot documentSnapshot) =>
            documentSnapshot.data['name'] == keyword)
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
import 'package:cloud_firestore/cloud_firestore.dart';
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
}
