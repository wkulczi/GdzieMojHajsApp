import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              //LayoutTemplates.logo,
              Center(
                  child: Text(
                    "Security check successfull!\nNow you can change your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  )),
              Center(
                  child: Text(
                    "Your password is: " +
                        RemindPasswordAnswerPage.actual_password,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: UserDefaultButton(
                      text: 'Back to login page',
                      onPressed: () {
                        actionLogout(context);
                      })),
            ]),
      ),
    );
  }
}
