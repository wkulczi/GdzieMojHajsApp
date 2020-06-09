import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/main.dart';
import 'package:gdziemojhajsapp/pages/AccountSettings/settings_page.dart';

class LayoutTemplates {
  static final insideColumnSeparator = SizedBox(height: 20);

  static final logo = Container(
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.receipt,
                size: 80.0,
                color: Colors.lightBlue,
              ),
              Text(
                "GdzieMójHaj\$",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ],
          )));

  final logoHero = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 50.0,
      child: Icon(
        Icons.receipt,
        size: 100.0,
      ),
    ),
  );

  final appName = Container(
      alignment: Alignment.center,
      child: Text(
        "GdzieMójHajs",
      ));
}

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        title: Text(
          "GdzieMójHaj\$",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Center(child: MyApp.activeUserNameTextWidget),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Next page',
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(UserSettingsPage.tag);
            },
          ),
        ]);
  }
}

class UserDefaultInputFrom extends StatelessWidget {
  const UserDefaultInputFrom({
    this.key,
    @required this.hint,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.controller,
    this.obscureText = false,
    this.validator,
  });

  final Key key;
  final String hint;
  final bool autofocus;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: TextFormField(
          keyboardType: this.keyboardType,
          autofocus: this.autofocus,
          obscureText: this.obscureText,
          controller: this.controller,
          validator: this.validator,
          decoration: InputDecoration(
            hintText: this.hint,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        ));
  }
}

class UserDefaultButton extends StatelessWidget {
  const UserDefaultButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: this.onPressed,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(this.text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class UserSettingsButton extends StatelessWidget {
  const UserSettingsButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: this.onPressed,
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Text(this.text, style: TextStyle(color: Colors.white)),
    );
  }
}

class UserDefaultLabel extends StatelessWidget {
  const UserDefaultLabel({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: this.onPressed);
  }
}

class UserDefaultBackLabel extends StatelessWidget {
  const UserDefaultBackLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(
          translate("back-to-previous-button"),
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}

class UserDialog extends StatelessWidget {
  final String text;
  final bool barrierDismissible = true;

  const UserDialog({
    @required this.text,
    bool barrierDismissible,
  });

  @override
  Widget build(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(this.text, textAlign: TextAlign.center),
          );
        });
  }
}
