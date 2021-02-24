import 'package:demo_project/constants/color.dart';
import 'package:demo_project/constants/string.dart';
import 'package:demo_project/models/app_state.dart';
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/redux/actions/ui_actions.dart';
import 'package:demo_project/redux/middlewares/platform_specific_functions/android/local_notifications.dart';
import 'package:demo_project/redux/middlewares/ui_functions/product_functions.dart';
import 'package:demo_project/widgets/loader.dart';
import 'package:demo_project/widgets/product_screen/appbar_icons.dart';
import 'package:demo_project/widgets/product_screen/bottom_button.dart';
import 'package:demo_project/widgets/product_screen/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ProductScreen extends StatefulWidget {
  final Store store;
  ProductScreen({@required this.store});
  _ProductScreen createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  bool loading = true; // for loader state
  bool errorLoading = false; // for unexpected errors while loading

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size size = MediaQuery.of(context).size;
    widget.store.dispatch(ActionStoreHeight(size.height));
    widget.store.dispatch(ActionStoreWidth(size.width));
  }

  void loadProducts() async {
    bool loaded = await fetchProducts(store: widget.store);
    if (loaded) {
      //remove loader if data loaded successfully
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        errorLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) {
      return ViewModel.create(store);
    }, builder: (BuildContext context, ViewModel viewModel) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(viewModel),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: loading
                      //show loader while data is loading
                      ? Container(
                          alignment: Alignment.center,
                          child: Container(child: loader()),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: viewModel.products.length == 0
                              //show message String if there are 0 products after loading
                              ? noProductWidget(viewModel)
                              : Column(
                                  children: [
                                    listHeader(viewModel),
                                    Expanded(
                                      child: gridView(viewModel),
                                    )
                                  ],
                                ))),
              bottomBar(viewModel)
            ],
          ),
        ),
      );
    });
  }

  Widget gridView(ViewModel viewModel) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (viewModel.height / viewModel.width) / 3.2,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return ProductTile(
            store: widget.store, product: viewModel.products[index]);
      },
      itemCount: viewModel.products.length,
    );
  }

  Container bottomBar(ViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          BottomButton(
              iconData: Icons.swap_vert, onClick: () {}, label: "Sort"),
          Container(
            width: 1.5,
            height: 30,
            color: greyColor,
          ),
          BottomButton(
              iconData: Icons.filter_alt, onClick: () {}, label: "Filter")
        ],
      ),
    );
  }

  Container listHeader(ViewModel viewModel) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "FIT LINEN SHIRTS",
            style: TextStyle(
                color: greyColor, fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            "+177 items",
            style: TextStyle(
                color: redColor, fontSize: 16.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Text noProductWidget(ViewModel viewModel) {
    return Text(
      noProductString,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: greyColor, fontWeight: FontWeight.bold, fontSize: 18.0),
    );
  }

  AppBar appBar(ViewModel viewModel) {
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 1.0,
      leading: Icon(
        Icons.arrow_back_rounded,
        color: blackColor,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "US POLO TAILORED FIT LINEN SHIRTS",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: blackColor, fontSize: 18.0),
          ),
          Text(
            "1 items",
            style: TextStyle(color: greyColor, fontSize: 12.0),
          ),
        ],
      ),
      actions: [
        AppBarIcons(
            icon: Icon(
              Icons.search,
              color: blackColor,
            ),
            onClick: () {}),
        AppBarIcons(
            icon: Icon(
              Icons.favorite_border,
              color: blackColor,
            ),
            onClick: ()  {
             showNotification();
            }),
        AppBarIcons(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: blackColor,
            ),
            isActive: true,
            onClick: () {}),
      ],
    );
  }
}

//this class exposes the the objects required from appState at this particular screen
class ViewModel {
  List<Product> products;
  double width, height;
  ViewModel({this.products, this.width, this.height});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        products: store.state.products,
        height: store.state.height,
        width: store.state.width);
  }
}
