import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/admin_modify_user_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/change_password_page.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/change_question_answer_page.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/setting_button.dart';

import '../../../main.dart';

Widget menu({context, slideAnimation, menuScaleAnimation, screenWidth}) {
  return SlideTransition(
    position: slideAnimation,
    child: ScaleTransition(
      scale: menuScaleAnimation,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 0.5 * screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Hello"),
                      Text(
                        MyApp.activeUser["login"],
                        style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                      ),
                    ],
                  ),
                ),
                settingButtonWidget(
                    icon: Icons.lock_outline,
                    settingTitle: "Change password",
                    onTap: () {
                      Navigator.of(context).pushNamed(ChangePasswordPage.tag);
                    }),
                settingButtonWidget(
                    icon: Icons.settings,
                    settingTitle: "Edit security question",
                    onTap: () {
                      Navigator.of(context).pushNamed(ChangeQuestionAnswerPage.tag);
                    }),
                settingButtonWidget(
                    icon: Icons.lock_open,
                    settingTitle: "Logout",
                    onTap: () {
                      actionLogout(context);
                    }),
                Visibility(
                    visible: MyApp.activeUser["role"] == 'admin',
                    child: settingButtonWidget(
                        icon: Icons.person_outline,
                        settingTitle: "Administration tools",
                        onTap: () {
                          Navigator.of(context).pushNamed(AdminModifyUserPage.tag);
                        })),
                Container(
                  height: 300,
                ) //im a hacker
              ],
            ),
          ),
        ),
      ),
    ),
  );
}