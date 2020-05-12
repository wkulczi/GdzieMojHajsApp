import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/AccountLayouts/receipt_layouts.dart';
import 'package:gdziemojhajsapp/pages/AccountLayouts/account_layouts.dart';

class HomePage extends StatefulWidget {
  static String tag = 'main-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UserAppBar(),
      body: ReceiptsListView(),
    );
  }
}