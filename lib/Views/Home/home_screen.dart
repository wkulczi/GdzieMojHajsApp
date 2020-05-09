import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gdziemojhajsapp/Constants/colors.dart';
import 'package:gdziemojhajsapp/Controllers/product_controller.dart';
import 'package:gdziemojhajsapp/Controllers/receipt_controller.dart';
import 'Widgets/default_app_bar.dart';
import 'Widgets/default_gradient_decoration.dart';

class HomeScreen extends StatefulWidget {
  static var tag= "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//todo import new font, prolly roboto or ubuntu

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ReceiptController receiptController = ReceiptController();
  ProductController productController = ProductController();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
//          receiptController.getReceipt(1);
            Navigator.pushNamed(context, "/newReceipt");
//          Navigator.of(context).pushNamed('/addReceipt');
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
