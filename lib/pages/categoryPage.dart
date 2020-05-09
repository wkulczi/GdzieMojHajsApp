import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CategoryPage extends StatefulWidget {
  static String tag = "category";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  Map data = {};
  double limit = 0.0;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent(data['name'], () => data['spent']);
    dataMap.putIfAbsent("Pozostałe", () => 70);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        title: Text(
                data['name'],
            ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "OPIS",
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              data['description']
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "WYDANE ŚRODKI",
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      data['spent'].toString() + " zł",
                      style: TextStyle(
                          fontSize: 40
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40.0),
                Column(
                  children: <Widget>[
                    Text(
                      "LIMIT ŚRODKÓW",
                      style: TextStyle(
                        letterSpacing: 2.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      limit.toString() + " zł",
                      style: TextStyle(
                          fontSize: 40
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              "PORÓWNANIE Z RESZTĄ WYDATKÓW",
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            PieChart(dataMap: dataMap),
            SizedBox(height: 15.0),
            Text(
              "ZMIANA LIMITU",
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Slider(
              value: limit.toDouble(),
              onChanged: (newLimit) {
                setState(() => limit = newLimit);
              },
              min: 0,
              max: 500,
              divisions: 250,
              label: limit.toString()
            )
          ],
        ),
      )
    );
  }
}
