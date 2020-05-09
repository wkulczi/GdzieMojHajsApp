import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/user/logic/user_logic.dart';
import '../logic/user_layouts.dart';

class ForgetPasswordPage extends StatefulWidget {
  static String tag = 'forget-password-page';

  @override
  _ForgetPasswordPageState createState() => new _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static final loginFormController = TextEditingController();
  static String question;
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
              child: UserDefaultInputFrom(
                  hint: 'Login',
                  autofocus: true,
                  controller: loginFormController,
                  validator: UserValidators.validateLogin),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: UserDefaultButton(
                  text: 'Remind my password',
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }

                    Map data = {"login": "${loginFormController.text}"};

                    _ForgetPasswordPageState.question =
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

class ForgetPasswordQuestionPage extends StatefulWidget {
  static String tag = 'forgetPasswordQuestion-page';

  @override
  _ForgetPasswordPageQuestionState createState() =>
      new _ForgetPasswordPageQuestionState();
}

class _ForgetPasswordPageQuestionState
    extends State<ForgetPasswordQuestionPage> {
  final answerFormController = TextEditingController();
  static String actual_password;

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
            //LayoutTemplates.logo,
            Center(
                child: Text(
              _ForgetPasswordPageState.question,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )),
            Form(
              key: _formKey,
              child: UserDefaultInputFrom(
                hint: 'Answer',
                autofocus: true,
                controller: answerFormController,
                validator: UserValidators.validateAnswer,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserDefaultButton(
                    text: 'Send answer',
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return null;
                      }

                      Map data = {
                        "login":
                            "${_ForgetPasswordPageState.loginFormController.text}",
                        "answer": "${this.answerFormController.text}"
                      };

                      _ForgetPasswordPageQuestionState.actual_password =
                          await actionRemindPasswordSendAnswer(context, data);
                    })),
            UserDefaultBackLabel()
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordSuccessPage extends StatefulWidget {
  static String tag = 'forgetPasswordSuccessPageState-page';

  @override
  _ForgetPasswordSuccessPageState createState() =>
      new _ForgetPasswordSuccessPageState();
}

class _ForgetPasswordSuccessPageState extends State<ForgetPasswordSuccessPage> {
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
                    _ForgetPasswordPageQuestionState.actual_password,
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
