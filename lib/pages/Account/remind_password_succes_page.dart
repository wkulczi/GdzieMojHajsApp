import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import 'package:gdziemojhajsapp/pages/Account/remind_password_answer_page.dart';
import 'package:gdziemojhajsapp/pages/AccountLayouts/account_layouts.dart';

class RemindPasswordSuccessPage extends StatefulWidget {
  static String tag = 'forgetPasswordSuccessPageState-page';

  @override
  _RemindPasswordSuccessPageState createState() =>
      new _RemindPasswordSuccessPageState();
}

class _RemindPasswordSuccessPageState extends State<RemindPasswordSuccessPage> {
  final passwordFormController = TextEditingController();
  final passwordRepeatFormController = TextEditingController();

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
              //LayoutTemplates.logo,
              Center(
                  child: Text(
                translate("remind-password-success-page-success"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translate("remind-password-success-page-password-text"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      RemindPasswordAnswerPage.actual_password,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ]),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: UserDefaultButton(
                      text: translate("remind-password-success-page-button"),
                      onPressed: () {
                        actionLogout(context);
                      })),
            ]),
      ),
    );
  }
}
