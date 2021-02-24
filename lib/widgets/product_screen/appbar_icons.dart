import 'package:demo_project/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  final Icon icon;
  final Function onClick;
  final bool isActive;
  AppBarIcons({@required this.icon, @required this.onClick, this.isActive})
      : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return isActive == null || isActive == false
        ? IconButton(
            icon: icon,
            onPressed: onClick,
            color: blackColor,
          )
        : Stack(
            alignment: Alignment.centerRight,
            children: [
              IconButton(
                icon: icon,
                onPressed: onClick,
                color: blackColor,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8, right: 5),
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(color: redColor, shape: BoxShape.circle),
                child: Text(
                  "1",
                  style: TextStyle(color: whiteColor, fontSize: 8.0),
                ),
              )
            ],
          );
  }
}
