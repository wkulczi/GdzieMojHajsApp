import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gmh_app/Constants/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//todo import new font, prolly roboto or ubuntu

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 960, height: 1600, allowFontScaling: true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[ColorStyles.mainThemeBackgroundGradientStart, ColorStyles.mainThemeBackgroundGradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.01, 1]),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(20),
              0,
              ScreenUtil().setWidth(20),
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
                              style: TextStyle(color: Colors.white,fontSize: 40),
                            ),
                          ))),
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                      child: Text("hai"),
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
          Navigator.of(context).pushNamed('/addReceipt');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
