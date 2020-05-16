import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Controllers/product_controller.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/receipt_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget dashboard({context, scaleAnimation, isCollapsed, screenWidth, duration, notifyParent}) {
  ProductController _productController = ProductController();
  return AnimatedPositioned(
    duration: duration,
    top: 0,
    bottom: 0,
    left: isCollapsed ? 0 : 0.45 * screenWidth,
    right: isCollapsed ? 0 : -0.55 * screenWidth,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: Material(
        color: Colors.white,
        elevation: 8,
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: <Widget>[
                  appBarWidget(notifyParent),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        bottomPage(),
                        receiptList(),
                        addWidget(_productController),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    ),
  );
}

bottomPage() {
  //todo zmodyfikować backend, potrzebujemy tego w bd
  double monthly = 0.00;
  double daily = 0.00;
  double minus_daily = 0.00;
  double subtract = 0.00;

  return Container(
    child: Stack(
      children: [
        Column(
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
              percent: 0.69,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              center: Text("hajs/$monthly."),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
              child: Text(
                "Twój dzienny hajs",
                style: TextStyle(fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.w400),
              ),
            ),
            LinearPercentIndicator(
              lineHeight: 18,
              percent: 0.15,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
              center: Text("$minus_daily/$daily"),
            ),
          ],
        ),
        Container(
            color: Colors.green.withOpacity(0.9),
            child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text("Todo", style: TextStyle(fontSize: 30),),
                ))),
      ],
    ),
    color: Colors.white,
  );
}

addWidget(_productController) {
  return Container(
    alignment: Alignment(0.9, 0.9),
    child: FloatingActionButton(
        child: Icon(Icons.print),
        onPressed: () {
          _productController.sendReceipt(
              receipt: ReceiptModel(sum: 20.0, companyName: "Biedronka", categoryName: "Rozrywka", products: [
            ProductModel(quantity: 1, name: "Pywo", price: 3.30),
            ProductModel(quantity: 1, name: "inne Pywo", price: 2.30)
          ]));
        }),
  );
}

appBarWidget(notifyParent) {
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
            "Twoje Paragony",
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
