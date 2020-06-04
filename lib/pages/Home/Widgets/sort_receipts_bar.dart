import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/Constants/receipt_sort_type_enum.dart';

import '../home_screen.dart';

class SortReceiptsBar extends StatefulWidget {
  SortReceiptsBar({Key key}) : super(key: key);

  static ReceiptSortTypeEnum selectedReceiptsSortType = ReceiptSortTypeEnum.cost;
  static bool isIncreasing = false;
  static String selectedSortName = "Cost";

  @override
  _SortReceiptsBarState createState() => _SortReceiptsBarState();
}

class _SortReceiptsBarState extends State<SortReceiptsBar> with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  Map<String, ReceiptSortTypeEnum> nameValueMap = {
    "Cost": ReceiptSortTypeEnum.cost,
    "Company": ReceiptSortTypeEnum.company_name,
    "Category": ReceiptSortTypeEnum.category_name
  };

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    if (!SortReceiptsBar.isIncreasing) {
      _arrowAnimation = Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
    } else {
      _arrowAnimation = Tween(begin: pi, end: 0.0).animate(_arrowAnimationController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
//          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),

      child: Row(children: [
        DropdownButton<String>(
          hint: Text("Select item"),
          value: SortReceiptsBar.selectedSortName,
          onChanged: (String value) {
            if (SortReceiptsBar.selectedSortName != value) {
              setState(() {
                SortReceiptsBar.selectedSortName = value;
                SortReceiptsBar.selectedReceiptsSortType = nameValueMap[value];
                HomeScreen.refreshLayouts();
              });
            }
          },
          items: nameValueMap.keys.map((String sortName) {
            return DropdownMenuItem<String>(
              value: sortName,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sortName,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        AnimatedBuilder(
          animation: _arrowAnimationController,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(_arrowAnimation.value),
            child: IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (SortReceiptsBar.isIncreasing) {
                    SortReceiptsBar.isIncreasing = false;
                  } else {
                    SortReceiptsBar.isIncreasing = true;
                  }

                  _arrowAnimationController.isCompleted
                      ? _arrowAnimationController.reverse()
                      : _arrowAnimationController.forward();

                  HomeScreen.refreshLayouts();
                });
              },
            ),
          ),
        ),
      ]),
    );
  }
}
