import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import 'package:gdziemojhajsapp/pages/Account/remind_password_login_page.dart';
import 'package:gdziemojhajsapp/pages/AccountLayouts/account_layouts.dart';

class RemindPasswordAnswerPage extends StatefulWidget {
  static String tag = 'forgetPasswordQuestion-page';
  static String actual_password;

  @override
  _RemindPasswordPageAnswerState createState() =>
      new _RemindPasswordPageAnswerState();
}

class _RemindPasswordPageAnswerState
    extends State<RemindPasswordAnswerPage> {
  final answerFormController = TextEditingController();


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
            //LayoutTemplates.logo,
            Center(
                child: Text(
                  RemindPasswordLoginPage.question,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )),
            Form(
              key: _formKey,
              child: UserDefaultInputFrom(
                hint: translate("remind-password-answer-page-answer"),
                autofocus: true,
                controller: answerFormController,
                validator: UserValidators.validateAnswer,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserDefaultButton(
                    text: translate("remind-password-answer-page-button"),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return null;
                      }

                      Map data = {
                        "login":
                        "${RemindPasswordLoginPage.login}",
                        "answer": "${this.answerFormController.text}"
                      };

                      RemindPasswordAnswerPage.actual_password =
                      await actionRemindPasswordSendAnswer(context, data);
                    })),
            UserDefaultBackLabel()
          ],
        ),
      ),
    );
  }
}