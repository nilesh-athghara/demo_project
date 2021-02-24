//this file contains all the network calls related to products in our e-comm application
//example fetch list of products, get details of a product, wishlist a product and so on..

import 'dart:convert';
import 'package:demo_project/constants/api.dart';
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/redux/actions/middlewares_actions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

Future<bool> fetchProducts({@required Store store}) async {
  bool fetched = false;
  final String url = "$masterApiUrl/60141159ef99c57c734b89aa";
  final response = await http.get(url);
  if (response.statusCode == 200) {
    fetched = true;
    List<Product> products =
        productFromJson(json.decode(response.body)["data"]);
    store.dispatch(ActionStoreProducts(products));
  }
  return fetched;
}
