import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayoutTemplates {
  static final insideColumnSeparator = SizedBox(height: 8);

  static final logo = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.receipt,
        size: 100.0,
        color: Colors.lightBlue,
      ),
      Text(
        "GdzieMójHaj\$",
        style: TextStyle(
          fontSize: 35,
        ),
      )
    ],
  );

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

class UserManagementDefaultInputFrom extends StatelessWidget {
  const UserManagementDefaultInputFrom({
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
    return Form(
      key: this.key,
        child :TextFormField(
          keyboardType: this.keyboardType,
          autofocus: this.autofocus,
          obscureText: this.obscureText,
          controller: this.controller,
          validator: this.validator,
          decoration: InputDecoration(
            hintText: this.hint,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        )
    );
  }
}

class UserManagementDefaultButton extends StatelessWidget {
  const UserManagementDefaultButton({
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

class UserManagementDefaultLabel extends StatelessWidget {
  const UserManagementDefaultLabel({
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

class UserManagementDefaultBackLabel extends StatelessWidget {
  const UserManagementDefaultBackLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(
          'Back to the previous page',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}