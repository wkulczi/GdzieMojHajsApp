import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import '../AccountLayouts/account_layouts.dart';

class RemindPasswordLoginPage extends StatefulWidget {
  static String tag = 'forget-password-page';
  static String question;
  static String login;

  @override
  _RemindPasswordLoginPageState createState() => new _RemindPasswordLoginPageState();
}

class _RemindPasswordLoginPageState extends State<RemindPasswordLoginPage> {
  static final loginFormController = TextEditingController();

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
              child: UserDefaultInputFrom(
                  hint: translate("remind-password-login-page-login"),
                  autofocus: true,
                  controller: loginFormController,
                  validator: UserValidators.validateLogin),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: UserDefaultButton(
                  text: translate("remind-password-login-page-button"),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }

                    Map data = {"login": "${loginFormController.text}"};

                    RemindPasswordLoginPage.login = loginFormController.text;
                    RemindPasswordLoginPage.question =
                        await actionRemindPassword(context, data);
                  }),
            ),
            UserDefaultBackLabel()
          ],
        ),
      ),
    );
  }
}



