import 'package:demo_project/constants/color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final IconData iconData;
  final Function() onclick;
  Button(
      {@required this.iconData,
      @required this.label,
      @required this.backgroundColor,
      @required this.onclick,
      @required this.textColor})
      : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onclick,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: lightGreyColor, width: 1.0)),
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: textColor,
            ),
            SizedBox(
              width: 3.0,
            ),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
            )
          ],
        ),
      ),
    ));
  }
}
