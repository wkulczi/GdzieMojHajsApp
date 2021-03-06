import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import '../AccountLayouts/account_layouts.dart';

class AdminModifyUserPage extends StatefulWidget {
  static String tag = 'admin-modify-user-page';

  @override
  _AdminModifyUserPageState createState() => new _AdminModifyUserPageState();
}

class _AdminModifyUserPageState extends State<AdminModifyUserPage> {
  final loginFormController = TextEditingController();
  final passwordFormController = TextEditingController();
  final questionFormController = TextEditingController();
  final answerFormController = TextEditingController();
  final roleFormController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LayoutTemplates.logo,
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    UserDefaultInputFrom(
                        hint: translate("admin-modify-page-login"),
                        controller: loginFormController,
                        validator: UserValidators.validateLogin),
                    UserDefaultInputFrom(
                        hint: translate("admin-modify-page-password"),
                        obscureText: true,
                        controller: passwordFormController,
                        validator: (value) {
                          if (passwordFormController.text != "") {
                            return UserValidators.validatePassword(value);
                          } else {
                            return null;
                          }
                        }),
                    UserDefaultInputFrom(
                        hint: translate("admin-modify-page-question"),
                        controller: questionFormController,
                        validator: (value) {
                          if (questionFormController.text != "") {
                            return UserValidators.validateQuestion(value);
                          } else {
                            return null;
                          }
                        }),
                    UserDefaultInputFrom(
                        hint: translate("admin-modify-page-answer"),
                        controller: answerFormController,
                        validator: (value) {
                          if (answerFormController.text != "") {
                            return UserValidators.validateAnswer(value);
                          } else {
                            return null;
                          }
                        }),
                    UserDefaultInputFrom(
                        hint: translate("admin-modify-page-role"),
                        controller: roleFormController,
                        validator: (value) {
                          if (roleFormController.text != "") {
                            return UserValidators.validateRole(value);
                          } else {
                            return null;
                          }
                        }),
                    LayoutTemplates.insideColumnSeparator,
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: UserDefaultButton(
                      text: translate("admin-modify-page-button"),
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return null;
                        }

                        Map data = {
                          "login": MyApp.activeUser["login"],
                          "password": MyApp.activeUser["password"],
                          "user_login": "${loginFormController.text}",
                          "user_password": "${passwordFormController.text}",
                          "user_question": "${questionFormController.text}",
                          "user_answer": "${answerFormController.text}",
                          "user_role": "${roleFormController.text}"
                        };

                        new List.from(data.keys).forEach((key) {
                          if (data[key] == "") {
                            data.remove(key);
                          }
                        });

                        print(data);

                        actionAdminModifyUser(context, data);
                      })),
              UserDefaultBackLabel()
            ]),
      ),
    );
  }
}
