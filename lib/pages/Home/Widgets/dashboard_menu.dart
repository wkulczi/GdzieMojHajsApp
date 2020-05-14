import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Controllers/product_controller.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/receipt_widgets.dart';

Widget dashboard({context,scaleAnimation, isCollapsed, screenWidth, duration, notifyParent}) {
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
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(20), horizontal: ScreenUtil().setWidth(5)),
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
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[Text("Spód")],
                              )
                            ],
                          ),
                          color: Colors.white,
                        ),
                        receiptList(),
                        Container(
                          alignment: Alignment(0.9, 0.9),
                          child: FloatingActionButton(
                              child: Icon(Icons.print),
                              onPressed: () {
                                _productController.sendReceipt(
                                    receipt: ReceiptModel(
                                        sum: 20.0,
                                        companyName: "Biedronka",
                                        categoryName: "Rozrywka",
                                        products: [
                                          ProductModel(quantity: 1, name: "Pywo", price: 3.30),
                                          ProductModel(quantity: 1, name: "inne Pywo", price: 2.30)
                                        ]));
                              }),
                        )
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