import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/constants/color.dart';
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ProductTile extends StatefulWidget {
  final Store store;
  final Product product;
  ProductTile({@required this.store, @required this.product})
      : super(key: UniqueKey());
  _ProductTile createState() => _ProductTile();
}

class _ProductTile extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: greyColor, width: 0.5)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: widget.product.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
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
                ),
                padding: EdgeInsets.all(1.0),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              width: double.infinity,
              color: whiteColor,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: greyColor,
                      )
                    ],
                  ),
                  Text(
                    widget.product.shortDesc,
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //used wrap here instead of row, So that Ui adjusts accordingly if a product has very high price
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "\u{20B9}${widget.product.discountPrice} ",
                        style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (widget.product.discountPercentage != null)
                        Text(
                          " ${widget.product.discountPercentage} OFF",
                          style: TextStyle(
                            color: redColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return DetailsScreen(
            product: widget.product,
            store: widget.store,
          );
        }));
      },
    );
  }
}
