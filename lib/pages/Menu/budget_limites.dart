import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Controllers/account_controller.dart';
import 'package:gdziemojhajsapp/pages/Menu/budget_limits_state.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SetLimits extends StatefulWidget {
  static String tag = "/set_limits";

  @override
  _SetLimitsState createState() => _SetLimitsState();
}

class _SetLimitsState extends State<SetLimits> {
  @override
  Widget build(BuildContext context) {
    final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          color: ColorStyles.hexToColor("#F8F8FF"),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 150,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(translate('limits-settings')),
                ),
                backgroundColor: Colors.transparent,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  translate('my-monthly-cash-left'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "${limitsState.getMonthlyLeft()}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "zł",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  translate('my-daily-cash-left'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "${limitsState.getDailyLeft()}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "zł",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FabCircularMenu(children: <Widget>[
          IconButton(
              icon: Icon(Icons.all_inclusive),
              onPressed: () {
                monthly_budget();
              }),
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                daily_budget();
              }),
          IconButton(
            icon: Icon(Icons.money_off),
            onPressed: () {
              minus_daily_budget();
            },
          )
        ]));
  }

  monthly_budget() {
    final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: translate('new-daily-budget'), contentPadding: EdgeInsets.all(5.0)),
              style: TextStyle(
                fontSize: 17.5,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                setState(() {
                  limitsState.changeMonthly(double.parse(text));
                  limitsState.changeMonthlyLeft(double.parse(text));
                });
                Map data = {
                  "login": "${MyApp.activeUser["login"]}",
                  "monthly": text
                };
                changeMonthlyLimit(context, data);
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(translate('close-window').toUpperCase()),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  daily_budget() {
    final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: InputDecoration(labelText: translate("your-daily-budget"), contentPadding: EdgeInsets.all(5.0)),
              style: TextStyle(
                fontSize: 17.5,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                setState(() {
                  limitsState.changeDaily(double.parse(text));
                  limitsState.changeDailyLeft(double.parse(text));
                });
                Map data = {
                  "login": "${MyApp.activeUser["login"]}",
                  "daily": text
                };
                changeDailyLimit(context, data);
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(translate('close-window').toUpperCase()),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  minus_daily_budget() {
    final LimitsState limitsState = Provider.of<LimitsState>(context, listen: false);
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: translate('insert-spent-money'), contentPadding: EdgeInsets.all(5.0)),
                style: TextStyle(
                  fontSize: 17.5,
                ),
                keyboardType: TextInputType.number,
                // ignore: missing_return
                onSubmitted: (text) {
                  setState(() {
                    limitsState.changeMonthlyLeft(limitsState.getMonthlyLeft()-double.parse(text));
                    limitsState.changeDailyLeft(limitsState.getDailyLeft()-double.parse(text));
                  });
                  if (limitsState.getDailyLeft() < 0) {
                    AlertDialog dial = new AlertDialog(
                      title: Text(translate('daily-limit-exceeded')),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                    showDialog(context: context, child: dial);
                  }
                }),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          // ignore: missing_return
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(translate('close-window').toUpperCase()),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }
}
