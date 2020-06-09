import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
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
                      Text(translate('welcome')),
                      Text(
                        MyApp.activeUser["login"],
                        style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                      ),
                    ],
                  ),
                ),
                settingButtonWidget(
                    icon: Icons.lock_outline,
                    settingTitle: translate('change-password'),
                    onTap: () {
                      Navigator.of(context).pushNamed(ChangePasswordPage.tag);
                    }),
                settingButtonWidget(
                    icon: Icons.settings,
                    settingTitle: translate('edit-sec-question'),
                    onTap: () {
                      Navigator.of(context).pushNamed(ChangeQuestionAnswerPage.tag);
                    }),
                settingButtonWidget(
                    icon: Icons.lock_open,
                    settingTitle: translate('logout'),
                    onTap: () {
                      actionLogout(context);
                    }),
                SwitchLanguageWidget(),
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

//print(localizationDelegate.currentLocale.languageCode=='en');
class SwitchLanguageWidget extends StatefulWidget {
  @override
  _SwitchLanguageWidgetState createState() => _SwitchLanguageWidgetState();
}

class _SwitchLanguageWidgetState extends State<SwitchLanguageWidget> {
  var actual_locale = "en_US";

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    updateActualLocale(localizationDelegate);
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                child: Icon(
                  Icons.language,
                  size: 18,
                ),
              ),
              Text(
                translate('change-lang'),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,left: 40),
            child: InkWell(
              child: Text(
                translate("english-lan") + "🇺🇸",
                style: actual_locale == 'en_US' ? TextStyle(fontSize: 16, fontWeight: FontWeight.w600) : TextStyle(color: ColorStyles.hexToColor("#303030"), fontSize: 16),
              ),
              onTap: () {
                if (actual_locale != 'en_US') {
                  changeLocale(context, 'en_US');
                }
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5,left: 40),
            child: InkWell(
              child: Text(
                translate('polish-lan')+ "🇵🇱",
                style: actual_locale == 'pl' ? TextStyle(fontSize: 16, fontWeight: FontWeight.w600) : TextStyle(color: ColorStyles.hexToColor("#303030"), fontSize: 16),
              ),
              onTap: () async {
                if (actual_locale != 'pl') {
                  changeLocale(context, 'pl');
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateActualLocale(LocalizationDelegate localizationDelegate) async {
    var locale;
    await localizationDelegate.preferences.getPreferredLocale().then((value) => locale = value.toString());
    setState(() {
      actual_locale = locale;
    });
  }
}

