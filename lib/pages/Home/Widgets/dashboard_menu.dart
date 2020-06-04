import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Constants/receipt_sort_type_enum.dart';
import 'package:gdziemojhajsapp/logic/Translation/app_localisations.dart';
import 'package:gdziemojhajsapp/pages/Categories/categories.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/receipt_widgets.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limites.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limits_state.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

import '../home_screen.dart';

//todo -> translate, dodawanie odręczne

Widget dashboard({context, scaleAnimation, isCollapsed, screenWidth, duration, notifyParent}) {
  return AnimatedPositioned(
    duration: duration,
    top: 0,
    bottom: 0,
    left: isCollapsed ? 0 : 0.45 * screenWidth,
    right: isCollapsed ? 0 : -0.55 * screenWidth,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: InkWell(
        onTap: () {
          if (!isCollapsed) {
            notifyParent();
          }
        },
        child: Material(
          color: Colors.white,
          elevation: 8,
          child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  children: <Widget>[
                    appBarWidget(context, notifyParent),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          bottomPage(context),
                          ReceiptList(isCollapsed),
                          addWidget(context),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    ),
  );
}

bottomPage(context) {
  final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
  //todo zmodyfikować backend, potrzebujemy tego w bd
  var monthly = limitsState.getMonthly() + limitsState.getSubtract();
  var daily = limitsState.getDaily();
  var minus_daily = limitsState.getMinusDaily();
  var subtract = limitsState.getSubtract();
  var monthly_minus_subtract = monthly - subtract;
  return Container(
    //todo daj tu ciemniejszy white
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Ustawienia limitów "),
                      Icon(Icons.settings),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SetLimits.tag);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Kategorie "),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Categories.tag);
                  },
                ),
              ),
            ],
          ),
        ),
        daily == 0
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "nie podano daily limitu 🦆",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                    child: Text(
                      "Mój miesięczny hajs",
                      style: TextStyle(fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.w400),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 18,
                    percent: monthly_minus_subtract / monthly,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                    center: Text("$monthly_minus_subtract/$monthly"),
                  )
                ],
              ),
        monthly == 0
//        todo lepsze info i kolorowanie based on % of budżet left
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("nie podano monthly limitu 🐕", style: TextStyle(fontSize: 20)),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                    child: Text(
                      "Twój dzienny hajs",
                      style: TextStyle(fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.w400),
                    ),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 18,
                    percent: minus_daily / daily,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                    center: Text("$minus_daily/$daily"),
                  ),
                ],
              ),
      ],
    ),
  );
}

addWidget(context) {
  return Container(
    alignment: Alignment(0.9, 1),
    child: speedDialWidget(context),
  );
}

Widget speedDialWidget(BuildContext context) {
  return UnicornDialer(
    hasNotch: true,
    parentButtonBackground: Colors.blue,
    orientation: UnicornOrientation.VERTICAL,
    parentButton: Icon(
      Icons.add,
      size: 2,
      color: Colors.white,
    ),
    childButtons: [
      UnicornButton(
        hasLabel: true,
        labelText: "Take a photo",
        currentButton: FloatingActionButton(
          heroTag: "Photo",
          backgroundColor: Colors.blue,
          mini: true,
          focusColor: Colors.blueAccent,
          child: Icon(Icons.camera),
          onPressed: () {
            return Flushbar(
              padding: EdgeInsets.all(10),
              borderRadius: 8,
              //todo customise if ya want
              backgroundColor: ColorStyles.hexToColor("#FEFEFE"),
              boxShadows: [
                BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
              ],
              duration: Duration(seconds: 3),
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
              forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
              titleText: Text(
                "Not implemented yet 😿",
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
              messageText: Text(
                "Sorry! 🙇‍♂️",
                style: TextStyle(color: Colors.black),
              ),
            )..show(context);
          },
        ),
      ),
      UnicornButton(
        hasLabel: true,
        labelText: "Add manually",
        currentButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          heroTag: "Manual",
          focusColor: Colors.blueAccent,
          mini: true,
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReceipt()));
          },
        ),
      ),
    ],
  );
}

appBarWidget(context, notifyParent) {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20), horizontal: ScreenUtil().setWidth(5)),
              child: Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
            ),
            onTap: () {
              notifyParent();
            },
          ),
          //todo import font
          Text(
            AppLocalizations.of(context).translate('receipt-list'),
            style: TextStyle(fontSize: ScreenUtil().setSp(45), fontWeight: FontWeight.w400),
          ),
          Container(
            color: Colors.transparent,
            child: Icon(
              Icons.check_box_outline_blank,
              color: Colors.transparent, //hax
            ),
          )
        ],
      ),
    ),
  );
}

class SortReceiptsBar extends StatefulWidget {
  SortReceiptsBar({Key key}) : super(key: key);

  static ReceiptSortTypeEnum selectedReceiptsSortType = ReceiptSortTypeEnum.cost;
  static bool isIncreasing = false;
  static String selectedSortName;

  @override
  _SortReceiptsBarState createState() => _SortReceiptsBarState();
}

class _SortReceiptsBarState extends State<SortReceiptsBar> with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  Map<String, ReceiptSortTypeEnum> nameValueMap = {"Cost": ReceiptSortTypeEnum.cost, "Company": ReceiptSortTypeEnum.company_name, "Category": ReceiptSortTypeEnum.category_name};

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
    return Row(children: [
      Container(
        color: Colors.white,
        child: DropdownButton<String>(
          hint: Text("Select item"),
          value: SortReceiptsBar.selectedSortName,
          onChanged: (String value) {
            setState(() {
              SortReceiptsBar.selectedSortName = value;
              SortReceiptsBar.selectedReceiptsSortType = nameValueMap[value];
              Navigator.of(context).popAndPushNamed(HomeScreen.tag);
//            HomeScreen.refreshFunc();
            });
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
      ),
      AnimatedBuilder(
        animation: _arrowAnimationController,
        builder: (context, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(_arrowAnimation.value),
          child: IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              setState(() {
                if (SortReceiptsBar.isIncreasing) {
                  SortReceiptsBar.isIncreasing = false;
                } else {
                  SortReceiptsBar.isIncreasing = true;
                }

                _arrowAnimationController.isCompleted ? _arrowAnimationController.reverse() : _arrowAnimationController.forward();

                Navigator.of(context).popAndPushNamed(HomeScreen.tag);
//                HomeScreen.refreshFunc();
              });
            },
          ),
        ),
      ),
    ]);
  }
}
