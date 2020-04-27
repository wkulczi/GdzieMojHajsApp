import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/user/logics/user_layouts.dart';


class MainPage extends StatefulWidget {
  static String tag = 'main-page';

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UserBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            LayoutTemplates.logo,
          ],
          //itemCount: 6,
        ),
      ),
    );
  }
}

//class ForgetPasswordQuestionPage extends StatefulWidget {
//  static String tag = 'forgetPasswordQuestion-page';
//
//  @override
//  _ForgetPasswordPageQuestionState createState() =>
//      new _ForgetPasswordPageQuestionState();
//}
//
//class _ForgetPasswordPageQuestionState
//    extends State<ForgetPasswordQuestionPage> {
//  final answerFormController = TextEditingController();
//  static String actual_password = "a";
//
//  @override
//  Widget build(BuildContext context) {
//    final questionText = Center(
//        child: Text(
//          _ForgetPasswordPageState.question,
//          style: TextStyle(
//              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
//        ));
//
//    final answerForm = UserDefaultInputFrom(
//      hint: 'Answer',
//      autofocus: true,
//      controller: answerFormController,
//    );
//
//    final sendAnswerButton = Padding(
//        padding: EdgeInsets.only(top: 8.0),
//        child: UserDefaultButton(
//            text: 'Send answer',
//            onPressed: () async {
//              Map payloadMap = {
//                "login": "${_ForgetPasswordPageState.loginFormController.text}",
//                "answer": "${this.answerFormController.text}"
//              };
//
//              var response = await http.post(
//                  MyApp.serverAddress + '/user/remind_password',
//                  body: json.encode(payloadMap),
//                  encoding: Encoding.getByName('utf-8'));
//
//              if (response.statusCode == 200) {
//                _ForgetPasswordPageQuestionState.actual_password =
//                jsonDecode(response.body)["actual_password"];
//                Navigator.of(context).pushNamed(ForgetPasswordSuccessPage.tag);
//              } else {
////                /// TODO: Wrong username, notify user
//              }
//            }));
//
//    List viewItemsList = [
//      LayoutTemplates.logo,
//      questionText,
//      answerForm,
//      sendAnswerButton,
//      UserDefaultBackLabel()
//    ];
//
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Center(
//        child: ListView.separated(
//          shrinkWrap: true,
//          padding: EdgeInsets.only(left: 24.0, right: 24.0),
//          separatorBuilder: (BuildContext context, int index) =>
//          const SizedBox(height: 8.0),
//          itemCount: viewItemsList.length,
//          itemBuilder: (BuildContext context, int index) {
//            return viewItemsList[index];
//          },
//        ),
//      ),
//    );
//  }
//}