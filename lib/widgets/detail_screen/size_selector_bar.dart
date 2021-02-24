import 'package:demo_project/constants/color.dart';
import 'package:demo_project/models/product_model.dart';
import 'package:demo_project/widgets/null_container.dart';
import 'package:flutter/material.dart';

class SizeSelectorBar extends StatefulWidget {
  final LongDesc desc;
  SizeSelectorBar({@required this.desc});
  _SizeSelectorBar createState() => _SizeSelectorBar();
}

class _SizeSelectorBar extends State<SizeSelectorBar> {
  int selectedIndex = -1;
  String selectedSize = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 15.0,
            child: selectedIndex != -1
                ? Text(
                    widget.desc.sizeDetails[selectedIndex][selectedSize],
                    style: TextStyle(color: blackColor, fontSize: 14),
                  )
                : nullContainer(),
          ),
          Container(
            width: double.infinity,
            height: 80,
            child: ListView.builder(
                itemCount: widget.desc.sizeDetails.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  String key;
                  for (String k in widget.desc.sizeDetails[index].keys) {
                    key = k;
                  }
                  return Container(
                    margin: EdgeInsets.all(6),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedSize = key;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          key,
                          style: TextStyle(
                              color: index == selectedIndex
                                  ? redColor
                                  : blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: index == selectedIndex
                                    ? redColor
                                    : blackColor,
                                width: 1.0)),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
