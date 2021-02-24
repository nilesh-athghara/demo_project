//this function connects our reducers to objects of our appState
import 'package:demo_project/models/app_state.dart';
import 'package:demo_project/redux/reducers/reducer_closures.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
      products: productReducer(state.products, action),
      width: widthReducer(state.width, action),
      height: heightReducer(state.height, action));
}
