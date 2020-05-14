import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Controllers/product_controller.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';
import 'package:gdziemojhajsapp/pages/AccountLayouts/receipt_layouts.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

import 'Widgets/default_gradient_decoration.dart';

class HomeScreen extends StatefulWidget {
  static var tag = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//todo import new font, prolly roboto or ubuntu

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  bool isCollapsed = true;
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.4, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    ScreenUtil.init(context, width: 960, height: 1600, allowFontScaling: true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //            dashboard(context),
          menu(context),
          newdashboard(context)
        ],
      ),
    );
  }

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
                    child: Text(
                      "Setting 1",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
                    child: Text(
                      "Setting 2",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
                    child: Text(
                      "Setting 3",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(9)),
                    child: Text(
                      "Setting 4",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newdashboard(BuildContext context) {
    ProductController _productController = ProductController();
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.3 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
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
                                setState(() {
                                  isCollapsed ? _controller.forward() : _controller.reverse();
                                  isCollapsed = !isCollapsed;
                                });
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

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.3 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          elevation: 8,
          child: Container(
            decoration: defaultGradientDecoration(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(30), //left
                  0,
                  ScreenUtil().setWidth(30), //right
                  ScreenUtil().setWidth(20),
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.dashboard,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isCollapsed ? _controller.forward() : _controller.reverse();
                                      isCollapsed = !isCollapsed;
                                    });
                                  },
                                ),
                                Text(
                                  "Hello User",
                                  style: TextStyle(color: Colors.white, fontSize: 40),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorStyles.hexToColor("#FEFEFE"),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
//                        child: FutureBuilder(
//                          future: ,
//                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {},),
                            child: Text("Here stuff"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
//  floatingActionButton: FloatingActionButton(
//  onPressed: () {
//  print('pressed');
////          receiptController.getReceipt(1);
//  Navigator.pushNamed(context, "/newReceipt");
////          Navigator.of(context).pushNamed('/addReceipt');
//  },
//  child: Icon(Icons.add),
//  ),
  }
}

Widget receiptList() {
  return FutureBuilder(
      future: ReceiptController.getAllAccountsReceipts(),
      builder: (context, snapshot) {
        return DraggableScrollableSheet(
            expand: true,
            initialChildSize: 1,
            minChildSize: 0.7,
            builder: (context, scrollController) {
              if (snapshot.hasError) {
                return receiptErrorWidget(snapshot: snapshot, scrollController: scrollController);
              } else if (ConnectionState.waiting == snapshot.connectionState) {
                return loadingWidget(scrollController: scrollController);
              } else if (ConnectionState.done == snapshot.connectionState && snapshot.hasData) {
                return receiptListWidget(snapshot: snapshot, scrollController: scrollController);
              } else {
                return noReceiptsWidget(scrollController: scrollController);
              }
            });
      });
}

Widget noReceiptsWidget({scrollController}) {
  return ListView(controller: scrollController, children: [
    Container(
        color: Colors.white,
        child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
              child: Column(
                children: <Widget>[
                  Icon(Icons.info_outline, color: Colors.blue, size: ScreenUtil().setSp(100)),
                  Text("Brak paragonów 🤷‍♂️", style: TextStyle(fontSize: ScreenUtil().setSp(50)))
                ],
              ),
            )))
  ]);
}

Widget receiptListWidget({snapshot, scrollController}) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      controller: scrollController,
      child: Column(
          children: snapshot.data.map<Widget>((Map data) {
            return ReceiptLayout(data["companyName"], data["sum"]);
          }).toList()),
    ),
  );
}

Widget loadingWidget({scrollController}) {
  return Container(
      color: Colors.white,
      child: ListView(controller: scrollController, children: [Center(child: CircularProgressIndicator())]));
}

Widget receiptErrorWidget({snapshot, scrollController}) {
  return Container(
    color: Colors.white,
    child: ListView(controller: scrollController, children: [
      Center(
          child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: ScreenUtil().setSp(100),
            ),
            Text(
              snapshot.error.toString(),
              style: TextStyle(fontSize: ScreenUtil().setSp(50)),
            ),
          ],
        ),
      ))
    ]),
  );
}
