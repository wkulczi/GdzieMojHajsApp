import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/user_management/forget_password_page.dart';
import 'package:gdziemojhajsapp/user_management/layout_templates.dart';
import 'package:gdziemojhajsapp/user_management/register_page.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormController = TextEditingController();
  final passwordFormController = TextEditingController();
  //final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginForm = UserManagementDefaultInputFrom(
        //key: _loginFormKey,
        hint: "Login",
        controller: loginFormController,
        validator: (value) {
          if (value.length < 2) {
            return "Login has to be at least 2 characters long";
          }
          return null;
        });

    final passwordForm = UserManagementDefaultInputFrom(
        hint: "Password",
        obscureText: true,
        controller: passwordFormController,
        validator: (value) {
          if (value.length < 2) {
            return "Login has to be at least 2 characters long";
          }

          return null;
        });

    final loginButton = Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: UserManagementDefaultButton(
          text: "Log In",
          onPressed: () async {
            Map payloadMap = {
              "login": "${loginFormController.text}",
              "password": "${passwordFormController.text}"
            };

            //if (_loginFormKey.currentState.validate()) {
              var response = await http.post(MyApp.serverAddress + '/login',
                  body: json.encode(payloadMap),
                  encoding: Encoding.getByName('utf-8'));

              if (response.statusCode == 200) {
                /// TODO: go to main menu
              } else {
//              /// TODO: Unauthorized, notify user
//
//                Scaffold.of(context).showSnackBar(SnackBar(
//                    content: Text(jsonDecode(response.body)["message"])));
              }
            //} else {}
          },
        ));

    final labelsRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        UserManagementDefaultLabel(
            text: "Don't have an account?",
            onPressed: () {
              Navigator.of(context).pushNamed(RegisterPage.tag);
            }),
        UserManagementDefaultLabel(
            text: 'Forgot your password?',
            onPressed: () {
              Navigator.of(context).pushNamed(ForgetPasswordPage.tag);
            }),
      ],
    );

    List viewItemsList = [
      LayoutTemplates.logo,
      loginForm,
      passwordForm,
      loginButton,
      labelsRow
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
          //itemCount: 6,
        ),
      ),
    );
  }
}
