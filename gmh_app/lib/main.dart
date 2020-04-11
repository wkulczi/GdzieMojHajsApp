import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'Views/add_receipt.dart';
import 'Views/home_screen.dart';
import 'Views/loading.dart';

void main() {
  runApp(RootPage());
}

class RootPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => HomeScreen(),
        '/addReceipt': (context) => AddReceipt(),
      },
    );
  }
}
