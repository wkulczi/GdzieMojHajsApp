import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/forget_password_page.dart';
import 'UserLayouts/user_layouts.dart';
import 'package:gdziemojhajsapp/pages/register_page.dart';
import 'package:gdziemojhajsapp/logic/user_logic.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormController = TextEditingController();
  final passwordFormController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            LayoutTemplates.logo,
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  UserDefaultInputFrom(
                      hint: "Login",
                      controller: loginFormController,
                      validator: UserValidators.validateLogin),
                  UserDefaultInputFrom(
                      hint: "Password",
                      obscureText: true,
                      controller: passwordFormController,
                      validator: UserValidators.validatePassword),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserDefaultButton(
                  text: "Log In",
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }

                    Map data = {
                      "login": "${loginFormController.text}",
                      "password": "${passwordFormController.text}"
                    };

                    actionLogin(context, data);
                  },
                )),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    UserDefaultLabel(
                        text: "Don't have an account?",
                        onPressed: () {
                          Navigator.of(context).pushNamed(RegisterPage.tag);
                        }),
                    UserDefaultLabel(
                        text: 'Forgot your password?',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgetPasswordPage.tag);
                        }),
                  ],
                ))
          ],
          //itemCount: 6,
        ),
      ),
    );
  }
}
