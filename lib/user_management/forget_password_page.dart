import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/user_management/login_page.dart';
import '../main.dart';
import 'layout_templates.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordPage extends StatefulWidget {
  static String tag = 'forgetPassword-page';

  @override
  _ForgetPasswordPageState createState() => new _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static final loginFormController = TextEditingController();
  static String question;

  @override
  Widget build(BuildContext context) {
    final loginForm = UserManagementDefaultInputFrom(
      hint: 'Login',
      autofocus: true,
      controller: loginFormController,
    );

    final remindButton = Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: UserManagementDefaultButton(
            text: 'Remind my password',
            onPressed: () async {
              Map payloadMap = {"login": "${loginFormController.text}"};

              var response = await http.post(
                  MyApp.serverAddress + '/user/remind_password',
                  body: json.encode(payloadMap),
                  encoding: Encoding.getByName('utf-8'));

              if (response.statusCode == 200) {
                _ForgetPasswordPageState.question =
                    jsonDecode(response.body)["question"];
                Navigator.of(context).pushNamed(ForgetPasswordQuestionPage.tag);
              } else {
//                /// TODO: Wrong username, notify user
              }
            }));

    List viewItemsList = [
      LayoutTemplates.logo,
      loginForm,
      remindButton,
      UserManagementDefaultBackLabel()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          separatorBuilder: (BuildContext context, int index) =>
              LayoutTemplates.insideColumnSeparator,
          itemCount: viewItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return viewItemsList[index];
          },
        ),
      ),
    );
  }
}

class ForgetPasswordQuestionPage extends StatefulWidget {
  static String tag = 'forgetPasswordQuestion-page';

  @override
  _ForgetPasswordPageQuestionState createState() =>
      new _ForgetPasswordPageQuestionState();
}

class _ForgetPasswordPageQuestionState
    extends State<ForgetPasswordQuestionPage> {
  final answerFormController = TextEditingController();
  static String actual_password = "a";

  @override
  Widget build(BuildContext context) {
    final questionText = Center(
        child: Text(
      _ForgetPasswordPageState.question,
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    ));

    final answerForm = UserManagementDefaultInputFrom(
      hint: 'Answer',
      autofocus: true,
      controller: answerFormController,
    );

    final sendAnswerButton = Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: UserManagementDefaultButton(
            text: 'Send answer',
            onPressed: () async {
              Map payloadMap = {
                "login": "${_ForgetPasswordPageState.loginFormController.text}",
                "answer": "${this.answerFormController.text}"
              };

              var response = await http.post(
                  MyApp.serverAddress + '/user/remind_password',
                  body: json.encode(payloadMap),
                  encoding: Encoding.getByName('utf-8'));

              if (response.statusCode == 200) {
                _ForgetPasswordPageQuestionState.actual_password =
                    jsonDecode(response.body)["actual_password"];
                Navigator.of(context).pushNamed(ForgetPasswordSuccessPage.tag);
              } else {
//                /// TODO: Wrong username, notify user
              }
            }));

    List viewItemsList = [
      LayoutTemplates.logo,
      questionText,
      answerForm,
      sendAnswerButton,
      UserManagementDefaultBackLabel()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 8.0),
          itemCount: viewItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return viewItemsList[index];
          },
        ),
      ),
    );
  }
}

class ForgetPasswordSuccessPage extends StatefulWidget {
  static String tag = 'forgetPasswordSuccessPageState-page';

  @override
  _ForgetPasswordSuccessPageState createState() =>
      new _ForgetPasswordSuccessPageState();
}

class _ForgetPasswordSuccessPageState extends State<ForgetPasswordSuccessPage> {
  final passwordFormController = TextEditingController();
  final passwordRepeatFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final successText = Center(
        child: Text(
      "Security check successfull!\nNow you can change your password.",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
    ));

    final passwordText = Center(
        child: Text(
      "Your password is: " + _ForgetPasswordPageQuestionState.actual_password,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    ));

    final backToLoginButton = Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: UserManagementDefaultButton(
            text: 'Back to login page',
            onPressed: () {
              Navigator.of(context).popAndPushNamed(LoginPage.tag);
              //Navigator.of(context).popUntil(ModalRoute.withName('login-page'));
            }));

    List viewItemsList = [
      LayoutTemplates.logo,
      successText,
      passwordText,
      backToLoginButton,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 8.0),
          itemCount: viewItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return viewItemsList[index];
          },
        ),
      ),
    );
  }
}
//class ForgetPasswordSuccessPage extends StatefulWidget {
//  static String tag = 'forgetPasswordSuccessPageState-page';
//
//  @override
//  _ForgetPasswordSuccessPageState createState() =>
//      new _ForgetPasswordSuccessPageState();
//}
//
//class _ForgetPasswordSuccessPageState extends State<ForgetPasswordSuccessPage> {
//  final passwordFormController = TextEditingController();
//  final passwordRepeatFormController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    final successText = Center(
//        child: Text(
//      "Security check successfull!\nNow you can change your password.",
//      textAlign: TextAlign.center,
//      style: TextStyle(
//          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
//    ));
//
//    final passwordsColumn = Column(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: <Widget>[
//        UserManagementDefaultInputFrom(
//          hint: 'Password',
//          obscureText: true,
//          controller: passwordFormController,
//        ),
//        LayoutTemplates.insideColumnSeparator,
//        UserManagementDefaultInputFrom(
//          hint: 'Repeat Password',
//          obscureText: true,
//          controller: passwordRepeatFormController,
//        ),
//      ],
//    );
//
//    final changePasswordButton = Padding(
//        padding: EdgeInsets.only(top: 8.0),
//        child: UserManagementDefaultButton(
//            text: 'Change password',
//            onPressed: () {
//              Navigator.of(context).popAndPushNamed(LoginPage.tag);
//              //Navigator.of(context).popUntil(ModalRoute.withName('login-page'));
//            }));
//
//    List viewItemsList = [
//      LayoutTemplates.logo,
//      successText,
//      passwordsColumn,
//      changePasswordButton,
//    ];
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Center(
//        child: ListView.separated(
//          shrinkWrap: true,
//          padding: EdgeInsets.only(left: 24.0, right: 24.0),
//          separatorBuilder: (BuildContext context, int index) =>
//              const SizedBox(height: 8.0),
//          itemCount: viewItemsList.length,
//          itemBuilder: (BuildContext context, int index) {
//            return viewItemsList[index];
//          },
//        ),
//      ),
//    );
//  }
//}
