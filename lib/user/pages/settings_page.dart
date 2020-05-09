import 'package:flutter/material.dart';
import '../logic/user_layouts.dart';
import 'package:gdziemojhajsapp/user/logic/user_logic.dart';
import 'package:gdziemojhajsapp/user/pages/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/user/pages/change_password_page.dart';
import 'package:gdziemojhajsapp/user/pages/change_question_answer_page.dart';
import 'package:gdziemojhajsapp/main.dart';

class UserSettingsPage extends StatefulWidget {
  static String tag = 'user-settings-page';

  @override
  _UserSettingsPageState createState() => new _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
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
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserSettingsButton(
                  text: "Change password",
                  onPressed: () {
                    Navigator.of(context).pushNamed(ChangePasswordPage.tag);
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserSettingsButton(
                  text: "Change security question and answer",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ChangeQuestionAnswerPage.tag);
                  },
                )),
            checkIfAdmin(),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: UserDefaultLabel(
                  text: "Logout",
                  onPressed: () {
                    actionLogout(context);
                  },
                )),
          ],
          //itemCount: 6,
        ),
      ),
    );
  }

  Widget checkIfAdmin() {
    if (MyApp.activeUser["role"] == 'admin') {
      return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: UserSettingsButton(
            text: "Administration Tools",
            onPressed: () {
              Navigator.of(context).pushNamed(AdminModifyUserPage.tag);
            },
          ));
    } else {
      return Container();
    }
  }
}
