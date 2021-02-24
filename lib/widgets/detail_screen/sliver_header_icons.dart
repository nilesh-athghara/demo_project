import 'package:demo_project/constants/color.dart';
import 'package:flutter/material.dart';

class SliverHeaderIcon extends StatelessWidget {
  final IconData iconData;
  final Function() onClick;
  final bool spaced;

  SliverHeaderIcon(
      {this.spaced = true, @required this.iconData, @required this.onClick})
      : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin:
          spaced ? EdgeInsets.symmetric(horizontal: 1.5) : EdgeInsets.all(0),
      child: InkWell(
        child: Container(
          height: 40,
          width: 40,
          child: Icon(
            iconData,
            color: blackColor,
            size: 20.0,
          ),
          decoration: BoxDecoration(shape: BoxShape.circle, color: whiteColor),
        ),
        onTap: onClick,
      ),
    );
  }
}
