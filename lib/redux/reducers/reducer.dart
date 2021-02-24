//this file contains blueprints of all our reducers
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/redux/actions/middlewares_actions.dart';
import 'package:demo_project/redux/actions/ui_actions.dart';

List<Product> storeProducts(
    List<Product> products, ActionStoreProducts action) {
  return action.products;
}

double storeHeight(double height, ActionStoreHeight action) {
  return action.height;
}

double storeWidth(double width, ActionStoreWidth action) {
  return action.width;
}
