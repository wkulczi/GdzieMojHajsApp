import 'package:flutter/material.dart';
import 'user_management/login_page.dart';
import 'user_management/register_page.dart';
import 'user_management/forget_password_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    ForgetPasswordQuestionPage.tag: (context) => ForgetPasswordQuestionPage(),
    ForgetPasswordSuccessPage.tag: (context) => ForgetPasswordSuccessPage()
  };

  static final String serverAddress = 'http://192.168.1.27:2137';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GdzieMojHajs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
