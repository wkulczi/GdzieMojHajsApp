import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/pages/Account/remind_password_answer_page.dart';
import 'package:gdziemojhajsapp/pages/Account/remind_password_succes_page.dart';
import 'package:gdziemojhajsapp/pages/Home/home_screen.dart';
import 'package:gdziemojhajsapp/pages/Account/login_page.dart';

import '../../main.dart';
import 'package:http/http.dart' as http;


class UserValidators {
  static String validatePassword(String value) {
    if (value != "test" && value.length < 6) {
      return translate("validator-password");
    }
    return null;
  }

  static String validateDoubledPassword(String value1, String value2) {
    if (validatePassword(value1) != null) {
      return validatePassword(value1);
    } else if (value1 != value2) {
      return translate("validator-doubled-password");
    }
    return null;
  }

  static String validateLogin(String value) {
    if (value != "test" && value.length < 6) {
      return translate("validator-login");
    }
    return null;
  }

  static String validateQuestion(String value) {
    if (value.length < 2) {
      return translate("validator-question");
    }
    return null;
  }

  static String validateAnswer(String value) {
    if (value.length < 2) {
      return translate("validator-answer");
    }
    return null;
  }

  static String validateRole(String value) {
    List availableRoles = ["admin", "user"];

    if (!availableRoles.contains(value)) {
      return translate("validator-role");
    }
    return null;
  }
}

void userShowDialog(var context, String text,
    {bool barrierDismissible = true,
    Duration duration = const Duration(milliseconds: 10),
    Function func}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text, textAlign: TextAlign.center),
        );
      });

  if (func != null) {
    Timer(duration, () {
      func();
    });
  }
}

void checkServerAvailability(var context) async {
  try {
    await http.get(MyApp.serverAddress + '/status');
  } on SocketException catch (_) {
    userShowDialog(context, translate("info-no-connection"),
        duration: Duration(seconds: 2), barrierDismissible: false, func: () {
      Navigator.of(context).pop();
    });
  }
}

void actionLogin(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.post(MyApp.serverAddress + '/login',
      body: json.encode(data), encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    MyApp.activeUser = data;
    MyApp.activeUser.addAll(jsonDecode(response.body));

    if (MyApp.activeUser["role"] == "admin") {
      MyApp.activeUserNameTextWidget = Text(MyApp.activeUser["login"],
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.yellow, fontSize: 18));
    } else {
      MyApp.activeUserNameTextWidget = Text(MyApp.activeUser["login"],
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18));
    }

    userShowDialog(context, translate("info-success-login"), barrierDismissible: false,
        func: () {
      Navigator.of(context).popAndPushNamed(HomeScreen.tag);
    });
  } else {
    userShowDialog(context, translate("info-fail-login"),
        duration: Duration(seconds: 1), func: () {
      Navigator.of(context).pop();
    });
  }
}

void actionRegister(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.post(MyApp.serverAddress + '/register',
      body: json.encode(data), encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 201) {
    userShowDialog(context, "info-success-register",
        barrierDismissible: false, func: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  } else {
    userShowDialog(context, "info-fail-register",
        duration: Duration(seconds: 2), func: () {
      Navigator.of(context).pop();
    });
  }
}

Future<String> actionRemindPassword(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.post(
      MyApp.serverAddress + '/account/remind_password',
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    Navigator.of(context).pushNamed(RemindPasswordAnswerPage.tag);
    return jsonDecode(response.body)["question"];
  } else {
    userShowDialog(context, translate("info-remind-wrong-login"), duration: Duration(seconds: 2),
        func: () {
      Navigator.of(context).pop();
    });
    return null;
  }
}

Future<String> actionRemindPasswordSendAnswer(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.post(
      MyApp.serverAddress + '/account/remind_password',
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    Navigator.of(context).pushNamed(RemindPasswordSuccessPage.tag);
    return jsonDecode(response.body)["actual_password"];
  } else {
    userShowDialog(context, translate("info-remind-wrong-answer"), duration: Duration(seconds: 2),
        func: () {
      Navigator.of(context).pop();
    });
    return null;
  }
}

actionChangeQuestionAnswer(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.put(
      MyApp.serverAddress + '/account/change_question_answer',
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    userShowDialog(
        context, translate("info-success-change-question"),
        barrierDismissible: false, func: () {
      actionLogout(context);
    });
  } else {
    userShowDialog(context, translate("info-fail-change-question"),
        duration: Duration(seconds: 2), func: () {
      Navigator.of(context).pop();
    });
  }
}

actionChangePassword(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.put(
      MyApp.serverAddress + '/account/change_password',
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    userShowDialog(context, translate("info-success-change-password"),
        barrierDismissible: false, func: () {
      actionLogout(context);
    });
  } else {
    userShowDialog(context, translate("info-fail-change-question"),
        duration: Duration(seconds: 2), func: () {
      Navigator.of(context).pop();
    });
  }
}

actionAdminModifyUser(var context, Map data) async {
  checkServerAvailability(context);

  var response = await http.put(
      MyApp.serverAddress + '/account/admin/modify_user',
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'));

  if (response.statusCode == 200) {
    userShowDialog(context, translate("info-success-admin-modify"),
        duration: Duration(seconds: 2), func: () {
      Navigator.of(context).pop();
    });
  } else {
    userShowDialog(context, translate("info-fail-admin-modify"),
        duration: Duration(seconds: 2), func: () {
      Navigator.of(context).pop();
    });
  }
}

actionLogout(var context) {
  MyApp.activeUser = new Map();

  Navigator.of(context)
      .pushNamedAndRemoveUntil(LoginPage.tag, (Route<dynamic> route) => false);
}
