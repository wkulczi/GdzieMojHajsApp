import 'package:flutter/material.dart';
import '../AccountLayouts/account_layouts.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';

class ChangeQuestionAnswerPage extends StatefulWidget {
  static String tag = 'change-question-answer-page';

  @override
  _ChangeQuestionAnswerPageState createState() =>
      new _ChangeQuestionAnswerPageState();
}

class _ChangeQuestionAnswerPageState extends State<ChangeQuestionAnswerPage> {
  final questionFormController = TextEditingController();
  final answerFormController = TextEditingController();
  final actualPasswordFormController = TextEditingController();

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
                children: <Widget>[ UserDefaultInputFrom(
                    hint: 'Actual password',
                    obscureText: true,
                    controller: actualPasswordFormController,
                    validator: UserValidators.validateAnswer),
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
                  text: "Change security question and answer",
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return null;
                    }

                    Map data = {
                      "login": "${MyApp.activeUser["login"]}",
                      "password": "${actualPasswordFormController.text}",
                      "question": "${questionFormController.text}",
                      "answer": "${answerFormController.text}"
                    };

                    actionChangeQuestionAnswer(context, data);

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
