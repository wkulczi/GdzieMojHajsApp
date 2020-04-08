import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:http/http.dart' as http;
import 'layout_templates.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final loginFormController = TextEditingController();
  final passwordFormController = TextEditingController();
  final passwordRepeatFormController = TextEditingController();
  final questionFormController = TextEditingController();
  final answerFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginForm = UserManagementDefaultInputFrom(
      hint: 'Login',
      controller: loginFormController,
    );

    final passwordsColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        UserManagementDefaultInputFrom(
          hint: 'Password',
          obscureText: true,
          controller: passwordFormController,
        ),
        LayoutTemplates.insideColumnSeparator,
        UserManagementDefaultInputFrom(
          hint: 'Repeat Password',
          obscureText: true,
          controller: passwordRepeatFormController,
        ),
      ],
    );

    final securityQuestionAndAnswerColumn = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        UserManagementDefaultInputFrom(
          hint: 'Security Question',
          controller: questionFormController,
        ),
        LayoutTemplates.insideColumnSeparator,
        UserManagementDefaultInputFrom(
          hint: 'Answer',
          controller: answerFormController,
        ),
      ],
    );

    final registerButton = Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: UserManagementDefaultButton(
            text: 'Register',
            onPressed: () async {
              if (passwordFormController.text !=
                  passwordRepeatFormController.text) {
                ///TODO: Unequal passwords, notify user
                return null;
              }

              Map payloadMap = {
                "login": "${loginFormController.text}",
                "password": "${passwordFormController.text}",
                "question": "${questionFormController.text}",
                "answer": "${answerFormController.text}"
              };

              var response = await http.post(MyApp.serverAddress + '/register',
                  body: json.encode(payloadMap),
                  encoding: Encoding.getByName('utf-8'));
              if (response.statusCode == 201) {
                //TODO: succes, notify user
                Navigator.of(context).pop();
              }else {
                ///TODO:failure, notify user
              }
            }));

    List viewItemsList = [
      LayoutTemplates.logo,
      loginForm,
      passwordsColumn,
      securityQuestionAndAnswerColumn,
      registerButton,
      UserManagementDefaultBackLabel()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 20.0),
          itemCount: viewItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return viewItemsList[index];
          },
        ),
      ),
    );
  }
}
