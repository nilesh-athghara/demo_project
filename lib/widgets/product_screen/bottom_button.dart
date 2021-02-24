import 'package:demo_project/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final IconData iconData;
  final Function onClick;
  final String label;
  BottomButton(
      {@required this.iconData, @required this.onClick, @required this.label})
      : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(onTap: onClick,child: Container(
          height: 55.0,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: greyColor,
              ),
              Text(
                label,
                style: TextStyle(
                    color: greyColor, fontWeight: FontWeight.bold, fontSize: 16.0),
              )
            ],
          ),
        ),));
  }
}
