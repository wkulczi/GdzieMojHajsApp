import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gmh_app/Constants/colors.dart';
import 'package:gmh_app/Controllers/product_controller.dart';
import 'package:gmh_app/Controllers/receipt_controller.dart';
import 'package:gmh_app/Models/receipt_model.dart';

import 'Widgets/default_app_bar.dart';
import 'Widgets/default_gradient_decoration.dart';
import 'exampleData.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//todo import new font, prolly roboto or ubuntu

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController;
  bool dialVisible = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ReceiptModel> _receipts = exampleData.receipts;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => Navigator.pushNamed(context, "/newReceipt"),
          label: 'Add receipt',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.camera, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => Navigator.pushNamed(context, "/ocr"),
          label: 'Take a photo',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 960, height: 1600, allowFontScaling: true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: defaultAppBar(),
        body: Container(
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
                            child: Center(
                          child: Text(
                            "Hello User",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ))),
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
                        child: Center(
                          child: Text("Receipt List and Stats here"),
                        ),
//                        child: receiptList(_receipts)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: buildSpeedDial()

//      FloatingActionButton(
//        onPressed: () {
//          print('pressed');
////          receiptController.getReceipt(1);
//            Navigator.pushNamed(context, "/newReceipt");
////          Navigator.of(context).pushNamed('/addReceipt');
//        },
//        child: Icon(Icons.add),
//      ),
        );
  }

  void getMoreData() {}

  Widget purchaseWidget(ReceiptModel receipt) {
    return Container(
      child: Column(
        children: <Widget>[
//          Text("hell")
          Container(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                child: Text(receipt.categoryName),
                padding: EdgeInsets.only(
                  right: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setHeight(25),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(receipt.shopName),
              Text(receipt.sum.toString() + " PLN")
            ],
          ),
          Container(
            child: Center(
              child: Padding(
                child: Text("Kliknij poznać szczegóły"),
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(50),
                    bottom: ScreenUtil().setHeight(20)),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  receiptList(List<ReceiptModel> _rec) {
    return ListView.builder(
        itemCount: _receipts.length,
        itemBuilder: (context, index) {
          return purchaseWidget(_rec[index]);
        });
  }
}
