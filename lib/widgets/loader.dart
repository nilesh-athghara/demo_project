import 'package:demo_project/constants/color.dart';
import 'package:flutter/material.dart';

Widget loader() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(greyColor),
  );
}
