import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import '../AccountLayouts/account_layouts.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final loginFormController = TextEditingController();
  final passwordFormController = TextEditingController();
  final repeatPasswordFormController = TextEditingController();
  final questionFormController = TextEditingController();
  final answerFormController = TextEditingController();

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    UserDefaultInputFrom(
                        hint: 'Login',
                        controller: loginFormController,
                        validator: UserValidators.validateLogin),
                    LayoutTemplates.insideColumnSeparator,
                    UserDefaultInputFrom(
                        hint: 'Password',
                        obscureText: true,
                        controller: passwordFormController,
                        validator: (value) {
                          return UserValidators.validateDoubledPassword(
                              value, repeatPasswordFormController.text);
                        }),
                    UserDefaultInputFrom(
                      hint: 'Repeat password',
                      obscureText: true,
                      controller: repeatPasswordFormController,
                      validator: (value) {
                        return UserValidators.validateDoubledPassword(
                            value, passwordFormController.text);
                      },
                    ),
                    LayoutTemplates.insideColumnSeparator,
                    UserDefaultInputFrom(
                        hint: 'Security Question',
                        controller: questionFormController,
                        validator: UserValidators.validateQuestion),
                    UserDefaultInputFrom(
                        hint: 'Answer',
                        controller: answerFormController,
                        validator: UserValidators.validateAnswer),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: UserDefaultButton(
                      text: 'Register',
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return null;
                        }

                        Map data = {
                          "login": "${loginFormController.text}",
                          "password": "${passwordFormController.text}",
                          "question": "${questionFormController.text}",
                          "answer": "${answerFormController.text}"
                        };

                        actionRegister(context, data);
                      })),
              UserDefaultBackLabel()
            ]),
      ),
    );
  }
}
