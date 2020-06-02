import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/settings_page.dart';
import 'package:gdziemojhajsapp/pages/Categories/categories.dart';
import 'package:gdziemojhajsapp/pages/Categories/categoryPage.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_transfer.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limites.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limits_state.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';
import 'package:gdziemojhajsapp/pages/Receipt/ocrReceipt.dart';
import 'package:provider/provider.dart';
import 'pages/Home/home_screen.dart';
import 'pages/Account/login_page.dart';
import 'pages/Account/register_page.dart';
import 'pages/Account/forget_password_page.dart';
import 'pages/AccountSettings/change_password_page.dart';
import 'pages/AccountSettings/change_question_answer_page.dart';

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
    LimitTransfer.tag: (context) => LimitTransfer(),
    SetLimits.tag: (context) => SetLimits(),
    OcrPage.tag:(context)=>OcrPage()
  };

  static final String serverAddress = 'http://192.168.1.65:5000';
  static Map activeUser;
  static Text activeUserNameTextWidget = Text("no_user");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LimitsState>.value(
          value: LimitsState(),
        ),
        ChangeNotifierProvider<CategoriesState>.value(
          value: CategoriesState(),
        )
      ],
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
