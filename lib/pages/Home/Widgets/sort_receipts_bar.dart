import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Constants/receipt_sort_type_enum.dart';


class SortReceiptsBar extends StatefulWidget {
  Function sortList;
  Function filterList;
  final TextEditingController textController;
  SortReceiptsBar({@required this.sortList, Key key, @required this.textController,  @required this.filterList}) : super(key: key);

  static ReceiptSortTypeEnum selectedReceiptsSortType = ReceiptSortTypeEnum.cost;
  static bool isIncreasing = false;
  static String selectedSortName = "Cost";

  @override
  _SortReceiptsBarState createState() => _SortReceiptsBarState(filter: filterList,reload: sortList, receiptTextController: textController);
}

class _SortReceiptsBarState extends State<SortReceiptsBar> with TickerProviderStateMixin {
  bool isSearchBarVisible = false;
  final Function reload;
  Function filter;
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;
  final TextEditingController receiptTextController;

  Map<String, ReceiptSortTypeEnum> nameValueMap = {"Cost": ReceiptSortTypeEnum.cost, "Company": ReceiptSortTypeEnum.company_name, "Category": ReceiptSortTypeEnum.category_name};

  _SortReceiptsBarState({@required this.reload, @required this.receiptTextController, @required this.filter});

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
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
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
                this.reload();
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

                  _arrowAnimationController.isCompleted ? _arrowAnimationController.reverse() : _arrowAnimationController.forward();

                  this.reload();
                });
              },
            ),
          ),
        ),
        Visibility(
          visible: isSearchBarVisible,
          child: Expanded(
            child: TextField(
              controller: receiptTextController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setWidth(30),
                ),
                hintText: 'Nazwa sklepu',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                )
              ),
              onChanged: (value) => this.filter(value),
            ),
          ),
        ),
        InkWell(
            onTap: () {
              this.isSearchBarVisible = !this.isSearchBarVisible;
              setState(() {});
            },
            child: Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Icon(Icons.search)))
      ]),
    );
  }
}
