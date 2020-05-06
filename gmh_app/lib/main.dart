import 'package:flutter/material.dart';

import 'Views/NewReceipt/add_receipt.dart';
import 'Views/Home/home_screen.dart';
import 'Views/PhotoSzit/main.dart';
import 'Views/loading.dart';
import 'Views/take_photo.dart';
import 'Views/test_view.dart';

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
        '/newReceipt': (context) => AddReceipt(),
        '/camera': (context) => MyApp(),
        '/testView': (context) => TestWidget(),
      },
    );
  }
}
