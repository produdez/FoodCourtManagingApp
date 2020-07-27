import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfoodcourt/models/dish.dart';
import 'package:fcfoodcourt/models/user.dart';
import 'package:fcfoodcourt/services/view_logic_helper.dart';
import 'package:fcfoodcourt/views/customer/Search/search_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fcfoodcourt/views/customer/Menu/customer_dish_list_view.dart';
import 'package:fcfoodcourt/views/customer/Menu/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fcfoodcourt/views/customer/Menu/dishes_of_vendor.dart';

bool firstFilter = false;
bool secondFilter = false;
bool thirdFilter = false;
double filter = 0;
String vendorID = "";

class SearchService extends SearchDelegate<String> {
  CollectionReference dishDB = Firestore.instance.collection("dishDB");
  CollectionReference vendorDB = Firestore.instance.collection("vendorDB");
  String vendorName = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          color: Color(0xffff8a84),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        color: Color(0xffff8a84),
        onPressed: () {
          vendorID = "";
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (currentIndex == 0) {
      if (query.isEmpty == true) {
        final suggestionList = SearchHelper.history.reversed.toSet().toList();
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () async {
              query = suggestionList[index];
              showResults(context);
            },
            leading: Icon(Icons.history),
            title: Text(suggestionList[index]),
          ),
          itemCount: suggestionList.length,
        );
      } else {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return StreamProvider<List<Dish>>.value(
              value: searchByName,
              child: WillPopScope(
                  onWillPop: () async {
                    vendorID = "";
                    setState(() {});
                    return true;
                  },
                  child: Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: firstFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: firstFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (firstFilter == false) {
                                    firstFilter = true;
                                    secondFilter = false;
                                    thirdFilter = false;
                                    filter = 1;
                                  } else {
                                    firstFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "< 30.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: secondFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: secondFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (secondFilter == false) {
                                    secondFilter = true;
                                    firstFilter = false;
                                    thirdFilter = false;
                                    filter = 2;
                                  } else {
                                    secondFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "30.000 đ - 50.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: thirdFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: thirdFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (thirdFilter == false) {
                                    thirdFilter = true;
                                    firstFilter = false;
                                    secondFilter = false;
                                    filter = 3;
                                  } else {
                                    thirdFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "> 50.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(child: SearchListView()),
                      ],
                    ),
                  )));
        });
      }
    } else {
      for (int i = 0; i < SearchHelper.searchHelper.length; i++) {
        if (vendorID == SearchHelper.searchHelper[i].vendorID) {
          vendorName = SearchHelper.searchHelper[i].vendorName;
        }
      }
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return StreamProvider<List<Dish>>.value(
            value: searchByName,
            child: WillPopScope(
                onWillPop: () async {
                  vendorID = "";
                  setState(() {});
                  return true;
                },
                child: Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                firstFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                firstFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              //Colors.white;
                              setState(() {
                                if (firstFilter == false) {
                                  firstFilter = true;
                                  secondFilter = false;
                                  thirdFilter = false;
                                  filter = 1;
                                  //init = Colors.red;
                                } else {
                                  firstFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "< 30.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                secondFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                secondFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                if (secondFilter == false) {
                                  secondFilter = true;
                                  firstFilter = false;
                                  thirdFilter = false;
                                  filter = 2;
                                } else {
                                  secondFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "30.000 đ - 50.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                thirdFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                thirdFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                if (thirdFilter == false) {
                                  thirdFilter = true;
                                  firstFilter = false;
                                  secondFilter = false;
                                  filter = 3;
                                } else {
                                  thirdFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "> 50.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(child: CustomerDishListView(vendorName)),
                    ],
                  ),
                )));
      });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (currentIndex == 0) {
      if (query.isEmpty == true) {
        final suggestionList = SearchHelper.history.reversed.toSet().toList();
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              query = suggestionList[index];
              showResults(context);
            },
            leading: Icon(Icons.history),
            title: Text(suggestionList[index]),
          ),
          itemCount: suggestionList.length,
        );
      } else {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return StreamProvider<List<Dish>>.value(
              value: searchByName,
              child: WillPopScope(
                  onWillPop: () async {
                    vendorID = "";
                    setState(() {});
                    return true;
                  },
                  child: Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: firstFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: firstFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (firstFilter == false) {
                                    firstFilter = true;
                                    secondFilter = false;
                                    thirdFilter = false;
                                    filter = 1;
                                    //init = Colors.red;
                                  } else {
                                    firstFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "< 30.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: secondFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: secondFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (secondFilter == false) {
                                    secondFilter = true;
                                    firstFilter = false;
                                    thirdFilter = false;
                                    filter = 2;
                                  } else {
                                    secondFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "30.000 đ - 50.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Color(0xffff8a84))),
                              color: thirdFilter
                                  ? Color(0xffff8a84)
                                  : Colors.white,
                              textColor: thirdFilter
                                  ? Colors.white
                                  : Color(0xffff8a84),
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                setState(() {
                                  if (thirdFilter == false) {
                                    thirdFilter = true;
                                    firstFilter = false;
                                    secondFilter = false;
                                    filter = 3;
                                  } else {
                                    thirdFilter = false;
                                    filter = 0;
                                  }
                                });
                              },
                              child: Text(
                                "> 50.000 đ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(child: SearchListView()),
                      ],
                    ),
                  )));
        });
      }
    } else {
      for (int i = 0; i < SearchHelper.searchHelper.length; i++) {
        if (vendorID == SearchHelper.searchHelper[i].vendorID) {
          vendorName = SearchHelper.searchHelper[i].vendorName;
        }
      }
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return StreamProvider<List<Dish>>.value(
            value: searchByName,
            child: WillPopScope(
                onWillPop: () async {
                  vendorID = "";
                  setState(() {});
                  return true;
                },
                child: Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                firstFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                firstFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                if (firstFilter == false) {
                                  firstFilter = true;
                                  secondFilter = false;
                                  thirdFilter = false;
                                  filter = 1;
                                  //init = Colors.red;
                                } else {
                                  firstFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "< 30.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                secondFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                secondFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                if (secondFilter == false) {
                                  secondFilter = true;
                                  firstFilter = false;
                                  thirdFilter = false;
                                  filter = 2;
                                } else {
                                  secondFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "30.000 đ - 50.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xffff8a84))),
                            color:
                                thirdFilter ? Color(0xffff8a84) : Colors.white,
                            textColor:
                                thirdFilter ? Colors.white : Color(0xffff8a84),
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                if (thirdFilter == false) {
                                  thirdFilter = true;
                                  firstFilter = false;
                                  secondFilter = false;
                                  filter = 3;
                                } else {
                                  thirdFilter = false;
                                  filter = 0;
                                }
                              });
                            },
                            child: Text(
                              "> 50.000 đ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(child: CustomerDishListView(vendorName)),
                    ],
                  ),
                )));
      });
    }
  }

  Future<void> passToSearchHelper() async {
    await vendorDB.getDocuments().then((snapshot) async {
      for (int i = 0; i < snapshot.documents.length; i++) {
        SearchHelper.searchHelper.add(SearchHelper(
            snapshot.documents[i].data['id'],
            snapshot.documents[i].data['name']));
      }
    });
    return null;
  }

  Stream<List<Dish>> get searchByName {
    return dishDB.snapshots().map(_dishListFromSnapshot);
  }

  List<Dish> _dishListFromSnapshot(QuerySnapshot snapshot) {
    if (vendorID == "") {
      if (filter == 0) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) => documentSnapshot
                .data['name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 1) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['realPrice'].toDouble() < 30000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 2) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['realPrice'].toDouble() <= 50000 &&
                documentSnapshot.data['realPrice'].toDouble() >= 30000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 3) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['realPrice'].toDouble() >= 50000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      }
    } else {
      if (filter == 0) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['vendorID'] == vendorID)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 1) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['vendorID'] == vendorID &&
                documentSnapshot.data['realPrice'].toDouble() < 30000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 2) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['vendorID'] == vendorID &&
                documentSnapshot.data['realPrice'].toDouble() <= 50000 &&
                documentSnapshot.data['realPrice'].toDouble() >= 30000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      } else if (filter == 3) {
        return snapshot.documents
            .where((DocumentSnapshot documentSnapshot) =>
                documentSnapshot.data['name']
                    .toLowerCase()
                    .contains(query.toLowerCase()) &&
                documentSnapshot.data['vendorID'] == vendorID &&
                documentSnapshot.data['realPrice'].toDouble() >= 50000)
            .map((doc) {
          return Dish(
            doc.data['name'] ?? '',
            doc.data['originPrice'].toDouble() ?? 0.0,
            discountPercentage: doc.data['discountPercentage'] ?? 0.0,
            realPrice: doc.data['realPrice'].toDouble() ?? 0.0,
            id: doc.data['id'] ?? '',
            vendorID: doc.data['vendorID'] ?? '',
            hasImage: doc.data['hasImage'] ?? false,
            isOutOfOrder: doc.data['isOutOfOrder'] ?? false,
          );
        }).toList();
      }
    }
  }
}

class SearchHelper {
  String vendorName;
  String vendorID;
  static String cusID;
  SearchHelper(this.vendorID, this.vendorName);
  static List<SearchHelper> searchHelper = [];
  static List<String> history = [];

  static Future<List<String>> getHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(cusID);
  }

  static Future<bool> setHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(cusID, history);
  }
}

// setListString(List<String> list, String cusID) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> listt;
//   await prefs.setStringList(cusID, list);
//   listt = prefs.getStringList(cusID);
//   return listt;
// }

// getListString(String cusID) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
// }
