import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/pages/settings_page.dart';
import 'pages/Home/home_screen.dart';
import 'pages/NewReceipt/add_receipt.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/forget_password_page.dart';
import 'home_page.dart';
import 'pages/change_password_page.dart';
import 'pages/change_question_answer_page.dart';
import 'package:gdziemojhajsapp/pages/categoryPage.dart';
import 'package:gdziemojhajsapp/pages/categories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    ForgetPasswordQuestionPage.tag: (context) => ForgetPasswordQuestionPage(),
    ForgetPasswordSuccessPage.tag: (context) => ForgetPasswordSuccessPage(),
    HomePage.tag: (context) => HomePage(),
    UserSettingsPage.tag: (context) => UserSettingsPage(),
    ChangePasswordPage.tag: (context) => ChangePasswordPage(),
    ChangeQuestionAnswerPage.tag: (context) => ChangeQuestionAnswerPage(),
    AdminModifyUserPage.tag: (context) => AdminModifyUserPage(),
    HomeScreen.tag: (context) => HomeScreen(),
    AddReceipt.tag: (context) => AddReceipt(),
    CategoryPage.tag: (context) => CategoryPage(),
    Categories.tag: (context) => Categories()
  };

  static final String serverAddress = 'http://192.168.1.23:2137';
  static Map activeUser;
  static Text activeUserNameTextWidget = Text("no_user");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GdzieMojHajs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: HomeScreen(),
      routes: routes,
    );
  }
}