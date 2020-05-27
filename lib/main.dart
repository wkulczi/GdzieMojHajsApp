import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/settings_page.dart';
import 'package:gdziemojhajsapp/pages/Menu/menu.dart';
import 'package:gdziemojhajsapp/pages/Menu/ola_state.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';
import 'package:provider/provider.dart';
import 'pages/Home/home_screen.dart';
import 'pages/Account/login_page.dart';
import 'pages/Account/register_page.dart';
import 'pages/Account/forget_password_page.dart';
import 'pages/AccountSettings/change_password_page.dart';
import 'pages/AccountSettings/change_question_answer_page.dart';
import 'file:///C:/Users/Evenlaxxus/AndroidStudioProjects/GdzieMojHajsApp/lib/pages/Categories/categoryPage.dart';
import 'file:///C:/Users/Evenlaxxus/AndroidStudioProjects/GdzieMojHajsApp/lib/pages/Categories/categories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    ForgetPasswordQuestionPage.tag: (context) => ForgetPasswordQuestionPage(),
    ForgetPasswordSuccessPage.tag: (context) => ForgetPasswordSuccessPage(),
    UserSettingsPage.tag: (context) => UserSettingsPage(),
    ChangePasswordPage.tag: (context) => ChangePasswordPage(),
    ChangeQuestionAnswerPage.tag: (context) => ChangeQuestionAnswerPage(),
    AdminModifyUserPage.tag: (context) => AdminModifyUserPage(),
    HomeScreen.tag: (context) => HomeScreen(),
    CreateReceipt.tag: (context) => CreateReceipt(),
    CategoryPage.tag: (context) => CategoryPage(),
    Categories.tag: (context) => Categories(),
    SetLimits.tag: (context) => SetLimits()
  };

  static final String serverAddress = 'http://10.0.2.2:5000';
  static Map activeUser;
  static Text activeUserNameTextWidget = Text("no_user");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LimitsState>.value(
      value: LimitsState(),
      child: MaterialApp(
        title: 'GdzieMojHajs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: 'Nunito',
        ),
        home: LoginPage(),
        routes: routes,
      ),
    );
  }
}
