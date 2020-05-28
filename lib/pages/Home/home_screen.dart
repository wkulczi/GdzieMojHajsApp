import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import '../../logic/utility.dart';
import 'Widgets/dashboard_menu.dart';
import 'Widgets/main_menu.dart';

class HomeScreen extends StatefulWidget {
  static var tag = "/home";
  static Function refreshLayouts;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//todo import new font, prolly roboto or ubuntu

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _screenWidth;
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
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    HomeScreen.refreshLayouts = () {
      setState(() {});
    };

    //loads categoryStates
    //todo-> load limits state
    Utility.reloadStates(context);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    HomeScreen.refreshFunc=refresh;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    ScreenUtil.init(context, width: 960, height: 1600, allowFontScaling: true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //            dashboard(context),
          menu(
              context: context,
              menuScaleAnimation: _menuScaleAnimation,
              screenWidth: _screenWidth,
              slideAnimation: _slideAnimation),
          dashboard(
              context: context,
              screenWidth: _screenWidth,
              duration: duration,
              isCollapsed: isCollapsed,
              scaleAnimation: _scaleAnimation,
              notifyParent: refresh),
          //DEV BUTTON FOR RELOADING STATE DATA
          Container(
            alignment: Alignment(-0.9, 0.9),
            child: FlatButton(
              child: Text("[Reload States]"),
              onPressed: () => Utility.reloadStates(context),
            ),
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {
      isCollapsed ? _controller.forward() : _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

}
