//this class represents the overall data state of our application
import 'dart:ui';
import 'package:demo_project/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class AppState {
  final List<Product> products;
  final double height;
  final double width;
  const AppState({this.products, this.height, this.width});
  factory AppState.initialState() {
    return AppState(products: [], height: 0, width: 0);
  }

  //helper methods for local storage(if needed)
  static AppState fromJson(dynamic json) {
    if (json == null) return null;
    return AppState(
      height: json["height"],
      width: json["width"],
      products:
          List<Product>.from(json["tasks"].map((x) => Product.fromJson(x))),
    );
  }

  dynamic toJson() => {
        "width": width,
        "height": height,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
