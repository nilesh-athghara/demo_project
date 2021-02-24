import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/blocs/details_screen/header_height_bloc.dart';
import 'package:demo_project/constants/color.dart';
import 'package:demo_project/models/app_state.dart';
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/widgets/detail_screen/buttons.dart';
import 'package:demo_project/widgets/detail_screen/size_selector_bar.dart';
import 'package:demo_project/widgets/detail_screen/sliver_header_icons.dart';
import 'package:demo_project/widgets/null_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DetailsScreen extends StatefulWidget {
  final Store store;
  final Product product;
  DetailsScreen({@required this.product, @required this.store});
  _DetailsScreen createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  ScrollController _scrollController = ScrollController();
  HeaderHeightBloc bloc = HeaderHeightBloc();
  bool scrolled = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) {
      return ViewModel.create(store);
    }, builder: (BuildContext context, ViewModel viewModel) {
      return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      backgroundColor: Colors.white,
                      pinned: true,
                      title: headerTitle(),
                      leading: SliverHeaderIcon(
                        spaced: false,
                        iconData: Icons.arrow_back_outlined,
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      actions: [
                        SliverHeaderIcon(
                          iconData: Icons.share,
                          onClick: () {},
                        ),
                        SliverHeaderIcon(
                          iconData: Icons.favorite_border,
                          onClick: () {},
                        ),
                        SliverHeaderIcon(
                          iconData: Icons.shopping_bag_outlined,
                          onClick: () {},
                        )
                      ],
                      elevation: 20,
                      expandedHeight: viewModel.height / 1.7,
                      flexibleSpace: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        //calculate flexible height to toggle header visibility status
                        double top = constraints.biggest.height;
                        double minimumHeight =
                            MediaQuery.of(context).padding.top +
                                kToolbarHeight +
                                50;
                        if (top < minimumHeight + 100 && !scrolled) {
                          scrolled = true;
                          bloc.query.add(true);
                        }
                        if (top > minimumHeight + 100 && scrolled) {
                          scrolled = false;
                          bloc.query.add(false);
                        }
                        return FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: backgroundImage(),
                        );
                      }),
                    )),
              ];
            },
            body: Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        priceAndNameRow(viewModel),
                        divider(),
                        discountDetailsRow(viewModel),
                        divider(),
                        exchangeDetails(viewModel),
                        divider(),
                        selectSizeRow(viewModel),
                        divider(),
                        detailsRow()
                      ]),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Container selectSizeRow(ViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SELECT SIZE",
                style: TextStyle(color: greyColor, fontSize: 14.0),
              ),
              InkWell(
                child: Text(
                  "SIZE CHART",
                  style: TextStyle(
                      color: redColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
            ],
          ),
          SizeSelectorBar(desc: widget.product.longDesc),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Button(
                  iconData: Icons.favorite_border,
                  label: "WISHLIST",
                  backgroundColor: whiteColor,
                  onclick: () {},
                  textColor: blackColor),
              SizedBox(
                width: 10,
              ),
              Button(
                  iconData: Icons.shopping_bag,
                  label: "ADD TO BAG",
                  backgroundColor: redColor,
                  onclick: () {},
                  textColor: whiteColor)
            ],
          )
        ],
      ),
    );
  }

  Container priceAndNameRow(ViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(10),
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "${widget.product.name}  ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: blackColor)),
              TextSpan(
                  text: widget.product.shortDesc,
                  style: TextStyle(fontSize: 14, color: greyColor))
            ])),
            margin: EdgeInsets.only(right: viewModel.width / 4),
          ),
          SizedBox(
            height: 20.0,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "\u{20B9}${widget.product.discountPrice} ",
                style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.product.discountPercentage != null)
                Text(
                  widget.product.origPrice,
                  style: TextStyle(
                    color: greyColor,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (widget.product.discountPercentage != null)
                Text(
                  " (${widget.product.discountPercentage} OFF)",
                  style: TextStyle(
                    color: redColor,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          Text("inclusive of all taxes",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: greenColor)),
        ],
      ),
    );
  }

  Container discountDetailsRow(ViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Text(
        widget.product.longDesc.discountDetails,
        style: TextStyle(color: greyColor, fontSize: 18),
      ),
    );
  }

  CachedNetworkImage backgroundImage() {
    return CachedNetworkImage(
      imageUrl: widget.product.imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(greyColor),
            value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.dry_cleaning,
        color: greyColor,
        size: 100,
      ),
    );
  }

  Container exchangeDetails(ViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Icon(
            Icons.cached,
            color: blackColor,
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
              child: Text(
                widget.product.longDesc.exchangeDtls,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget headerTitle() {
    return StreamBuilder(
      initialData: false,
      stream: bloc.counter,
      builder: (BuildContext context, AsyncSnapshot<bool> data) {
        return data.data
            ? Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            : nullContainer();
      },
    );
  }

  Container divider() {
    return Container(
      height: 8,
      color: Colors.grey[200],
    );
  }

  Container detailsRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.product.longDesc.details.map((e) {
          String key;
          for (String k in e.keys) {
            key = k;
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  key,
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.0),
                Text(
                  e[key],
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 14),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

//this class exposes the the objects required from appState at this particular screen
class ViewModel {
  double width, height;
  ViewModel({this.width, this.height});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(height: store.state.height, width: store.state.width);
  }
}
