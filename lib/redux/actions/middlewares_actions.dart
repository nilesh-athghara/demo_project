//this file contains action blueprints responsible for causing a change in appstate through middlewares

import 'package:demo_project/models/product_model.dart';

class ActionStoreProducts {
  final List<Product> products;
  ActionStoreProducts(this.products);
}
