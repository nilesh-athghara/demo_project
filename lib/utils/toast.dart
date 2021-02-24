import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// this function is used to display a toast message on the app.
// it is compatible with web as well.
void showToast(String message) {
  Fluttertoast.showToast(
    msg: "$message",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    fontSize: 13.0,
  );
}
