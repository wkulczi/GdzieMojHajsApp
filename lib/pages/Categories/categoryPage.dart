import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/Evenlaxxus/AndroidStudioProjects/GdzieMojHajsApp/lib/pages/Categories/limit_state.dart';

class CategoryPage extends StatefulWidget {
  static String tag = "/category_page";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

//    final LimitState limitState = Provider.of<LimitState>(context);
    final CategoriesState categoriesState = Provider.of<CategoriesState>(context);
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
                    data['spent'] > categoriesState.getLimit(data['name']) ?
                    Text(
                      data['spent'].toString() + " zł",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                      ),
                    ) :
                    Text(
                      data['spent'].toString() + " zł",
                      style: TextStyle(
                        fontSize: 40,
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
                      categoriesState.getLimit(data['name']).toString() + " zł",
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
              value: categoriesState.getLimit(data['name']).toDouble(),
              onChanged: (newLimit) {
                setState(() => categoriesState.changeLimit(data['name'], newLimit));
              },
              min: 0,
              max: 500,
              divisions: 500,
              label: categoriesState.getLimit(data['name']).toString()
            ),
            SizedBox(height: 5.0),
            data['spent'] > categoriesState.getLimit(data['name']) ?
            Text(
              "PRZEKROCZONO LIMIT",
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ):
            Text(
              "",
            ),
          ],
        ),
      )
    );
  }
}
