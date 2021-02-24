//this file contains all our reducers
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/redux/actions/middlewares_actions.dart';
import 'package:demo_project/redux/actions/ui_actions.dart';
import 'package:demo_project/redux/reducers/reducer.dart';
import 'package:redux/redux.dart';

Reducer<List<Product>> productReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, ActionStoreProducts>(storeProducts),
]);

Reducer<double> heightReducer = combineReducers<double>(
    [TypedReducer<double, ActionStoreHeight>(storeHeight)]);
Reducer<double> widthReducer = combineReducers<double>(
    [TypedReducer<double, ActionStoreWidth>(storeWidth)]);
