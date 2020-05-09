import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double monthly = 0.00;
  double daily = 0.00;
  double minus_daily = 0.00;
  double subtract = 0.00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gdzie mój hajs?'),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent[400],
        ),
        body: Column(
          children: <Widget>[
            Text(
              'Mój miesięczny hajs: $monthly zł.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              'Mój pozostały dzienny hajs: $minus_daily zł.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
        floatingActionButton: FabCircularMenu(
            children: <Widget>[
              IconButton(icon: Icon(Icons.all_inclusive), onPressed: () {
                monthly_budget();
              }),
              IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
                daily_budget();
              }),
              IconButton(icon: Icon(Icons.money_off), onPressed: (){
                minus_daily_budget();
              },

              )
            ]

        )
    );
  }

  monthly_budget() {
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Nowy miesięczny budżet',
                  contentPadding: EdgeInsets.all(5.0)
              ),
              style: TextStyle(
                fontSize: 17.5,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                print("Twój miesięczny hajs to: $text " + " zł.");
                setState(() {
                  monthly = double.parse(text);
                });
              },
            ),
          )
        ],
      ),
      actions: <Widget> [
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('ZAMKNIJ'),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  daily_budget(){
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Twój dzisiejszy budżet',
                  contentPadding: EdgeInsets.all(5.0)
              ),
              style: TextStyle(
                fontSize: 17.5,
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                print("Twój dzienny hajs to: $text " + " zł.");
                setState(() {
                  daily = double.parse(text);
                  minus_daily = double.parse(text);
                });
              },
            ),
          )
        ],
      ),
      actions: <Widget> [
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('ZAMKNIJ'),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  minus_daily_budget(){
    AlertDialog dialog = new AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Podaj kwotę zakupów: ',
                    contentPadding: EdgeInsets.all(5.0)
                ),
                style: TextStyle(
                  fontSize: 17.5,
                ),
                keyboardType: TextInputType.number,
                // ignore: missing_return
                onSubmitted: (text) {
                  print("Twój odjęty hajs to: $text " + " zł.");
                  setState(() {
                    subtract = double.parse(text);
                  });
                  minus_daily = minus_daily - subtract;
                  monthly = monthly - subtract;
                  if (minus_daily <= 0){
                    AlertDialog dial = new AlertDialog(
                      title: Text("Przekroczono dzienny limit wydatków!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){Navigator.pop(context);},
                          child: Text('OK'),
                        ),

                      ],
                    );
                    showDialog(context: context, child: dial);
                  }
                }
            ),
          )
        ],
      ),
      actions: <Widget> [
        FlatButton(
          // ignore: missing_return
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('ZAMKNIJ'),
        ),
      ],
    );
    showDialog(context: context, child: dialog);
  }
}