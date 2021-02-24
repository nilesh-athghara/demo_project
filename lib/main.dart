import 'dart:io';
import 'package:demo_project/models/app_state.dart';
import 'package:demo_project/redux/middlewares/platform_specific_functions/android/local_notifications.dart';
import 'package:demo_project/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/redux/reducers/app_reducer.dart';
import 'package:redux/redux.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //android background local notifications
  ///////////////////////////////////////////
  if (Platform.isAndroid) {
    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }
  Workmanager.cancelAll();
  Workmanager.registerPeriodicTask(
    "2",
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
  );
  /////////////////////////////////////////////////
  //this stores our appState's instance at any given point of time
  // we can use data from this anywhere in our app
  final Store<AppState> store = Store<AppState>(appStateReducer,
      initialState: AppState.initialState(), middleware: []);
  runApp(MyApp(
    store: store,
  ));
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    await showNotification();
    return Future.value(true);
  });
}
