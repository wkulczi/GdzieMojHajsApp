import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/receipt/logic/receipt_layouts.dart';
import 'package:gdziemojhajsapp/user/logic/user_layouts.dart';

class HomePage extends StatefulWidget {
  static String tag = 'main-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List receiptsList = [
    {"companyName": "biedra", "sum": 20},
    {"companyName": "biedra", "sum": 23},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UserAppBar(),
      body: ReceiptsListView(),
    );
  }
}
