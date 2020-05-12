import 'package:flutter/material.dart';
import '../AccountLayouts/account_layouts.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  static String tag = 'change-password-page';

  @override
  _ChangePasswordPageState createState() => new _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final actualPasswordFormController = TextEditingController();
  final newPasswordFormController = TextEditingController();
  final repeatNewPasswordFormController = TextEditingController();

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
              child: Column(children: <Widget>[
                UserDefaultInputFrom(
                    hint: 'Actual password',
                    obscureText: true,
                    controller: actualPasswordFormController,
                    validator: UserValidators.validateAnswer),
                LayoutTemplates.insideColumnSeparator,
                UserDefaultInputFrom(
                    hint: 'New password',
                    obscureText: true,
                    controller: newPasswordFormController,
                    validator: (value) {
                      return UserValidators.validateDoubledPassword(
                          value, repeatNewPasswordFormController.text);
                    }),
                UserDefaultInputFrom(
                  hint: 'Repeat new password',
                  obscureText: true,
                  controller: repeatNewPasswordFormController,
                  validator: (value) {
                    return UserValidators.validateDoubledPassword(
                        value, newPasswordFormController.text);
                  },
                ),
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserDefaultButton(
                  text: "Change password",
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }

                    Map data = {
                      "login": "${MyApp.activeUser["login"]}",
                      "password": "${actualPasswordFormController.text}",
                      "new_password": "${newPasswordFormController.text}"
                    };

                    actionChangePassword(context, data);
                  },
                )),
            UserDefaultBackLabel(),
          ],
          //itemCount: 6,
        ),
      ),
    );
  }
}
