import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/user/pages/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/user/pages/settings_page.dart';
import 'user/pages/login_page.dart';
import 'user/pages/register_page.dart';
import 'user/pages/forget_password_page.dart';
import 'main_page.dart';
import 'user/pages/change_password_page.dart';
import 'user/pages/change_question_answer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegisterPage.tag: (context) => RegisterPage(),
    ForgetPasswordPage.tag: (context) => ForgetPasswordPage(),
    ForgetPasswordQuestionPage.tag: (context) => ForgetPasswordQuestionPage(),
    ForgetPasswordSuccessPage.tag: (context) => ForgetPasswordSuccessPage(),
    MainPage.tag: (context) => MainPage(),
    UserSettingsPage.tag: (context) => UserSettingsPage(),
    ChangePasswordPage.tag: (context) => ChangePasswordPage(),
    ChangeQuestionAnswerPage.tag: (context) => ChangeQuestionAnswerPage(),
    AdminModifyUserPage.tag: (context) => AdminModifyUserPage(),
  };

  static final String serverAddress = 'http://192.168.1.14:2137';
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
      home: LoginPage(),
      routes: routes,
    );
  }
}
