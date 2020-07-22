import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'package:path_provider/path_provider.dart';
import 'package:fcfoodcourt/services/VendorReportDBService/vendor_report_db_service.dart';
import 'package:fcfoodcourt/models/vendor_report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void main() => runApp(MyApp());

const simpleTaskKey = "simpleTask";
const simpleDelayedTask = "simpleDelayedTask";
const simplePeriodicTask = "simplePeriodicTask";
const simplePeriodic1HourTask = "simplePeriodic1HourTask";

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    VendorReportDBService.vendorId = "DkSorWXHuraGVvywUDD6jU8b9ZE2";
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        var date = new DateTime(2018, 3, 31);
        var nextDate = new DateTime(date.year, date.month, date.day + 1);
        print(nextDate);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case simpleDelayedTask:
        print("Create Daily Report");
        //print("simpleDelayedTask was executed");
        List<Order> emptyList;
        print(VendorReportDBService.vendorId.toString());
        print("Create Daily Report");
        VendorReportDBService().createDailyReport(emptyList);
        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        print("Update Daily Report!!!");
        print(VendorReportDBService.vendorId.toString());
        //if(DateFormat('ddMMyyyy').format(DateTime.now()) != "22/07/2020")
        await VendorReportDBService().updateDailyReport(<Order>[Order(name: "pho", price: 400 , quantity: 1, revenue: 400 ),
        Order(name: "Hu tieu", price: 40, quantity: 2, revenue: 80 ), Order(name: "Bun Rieu", price: 40, quantity: 2, revenue: 80 )
        ]);


        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
      
        /*Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");*/
        break;
    }

    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
            child: child,
            onPressed:
                (Platform.isAndroid && platform == _Platform.android || Platform.isIOS && platform == _Platform.ios)
                    ? onPressed
                    : null);
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    VendorReportDBService.vendorId = "DkSorWXHuraGVvywUDD6jU8b9ZE2";
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter WorkManager Example"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Plugin initialization"),
              RaisedButton(
                  child: Text("Start the Flutter background service"),
                  onPressed: () {
                    print(VendorReportDBService.vendorId.toString());
                    Workmanager.initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
                  }),
              SizedBox(height: 16),
              Text("One Off Tasks (Android only)"),
              //This task runs once.
              //Most likely this will trigger immediately
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register OneOff Task"),
                  onPressed: () async{
                    print("here");
                    VendorReportDBService().updateDailyReport(<Order>[Order(name: "pho", price: 400 , quantity: 1, revenue: 400 ),
        Order(name: "Hu tieu", price: 40, quantity: 2, revenue: 80 ), Order(name: "Bun Rieu", price: 40, quantity: 2, revenue: 80 )
        ]);
                    Workmanager.registerOneOffTask(
                      "1",
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  }),
              //This task runs once
              //This wait at least 10 seconds before running
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register Delayed OneOff Task"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "2",
                      simpleDelayedTask,
                      //initialDelay: Duration(seconds: 2),
                    );
                  }),
              SizedBox(height: 8),
              Text("Periodic Tasks (Android only)"),
              //This task runs periodically
              //It will wait at least 10 seconds before its first launch
              //Since we have not provided a frequency it will be the default 15 minutes
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register Periodic Task"),
                  onPressed: () async{
                    Workmanager.registerPeriodicTask(
                      "3",
                      simplePeriodicTask,
                      //initialDelay: Duration(seconds: 2),
                      //frequency: Duration(seconds: 60)
                    );
                  }),
              //This task runs periodically
              //It will run about every hour
              PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register 1 hour Periodic Task"),
                  onPressed: () {
        //             VendorReportDBService().updateDailyReport(<Order>[Order(name: "pho", price: 400 , quantity: 1, revenue: 400 ),
        // Order(name: "Hu tieu", price: 40, quantity: 2, revenue: 80 ), Order(name: "Bun Rieu", price: 40, quantity: 2, revenue: 80 )
        // ]);
                    Workmanager.registerPeriodicTask(
                      "5",
                      simplePeriodic1HourTask,
                      frequency: Duration(minutes: 15),
                    );
                  }),
              PlatformEnabledButton(
                platform: _Platform.android,
                child: Text("Cancel All"),
                onPressed: () async {
                  await Workmanager.cancelAll();
                  print('Cancel all tasks completed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}