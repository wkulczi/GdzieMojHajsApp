import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Controllers/category_controller.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  static String tag = "/categoryPage";

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  double rest_of_the_money = 0;

  void getRestOfTheMoney() async {
    rest_of_the_money = await CategoryController.getSpentAll();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRestOfTheMoney();
  }

  @override
  Widget build(BuildContext context) {
    final CategoriesState categoriesState = Provider.of<CategoriesState>(context);
    Map data = ModalRoute.of(context).settings.arguments;
    Map<String, double> dataMap = new Map();      
    dataMap.putIfAbsent(data['name'], () => data['spent']);
//    Rafał ty gapciu, nie odejmowałeś od pozostałych tego, co w data['spent']
    dataMap.putIfAbsent("Pozostałe", () => rest_of_the_money-data['spent']);
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
                title: Text(
                  data['name'],
                ),
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
                              Text(data['description']),
                              SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      data['spent'] > categoriesState.getLimit(data['name'])
                                          ? Text(
                                              data['spent'].toStringAsFixed(2) + " zł",
                                              style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Text(
                                              data['spent'].toStringAsFixed(2) + " zł",
                                              style: TextStyle(
                                                fontSize: 40,
                                              ),
                                            ),
                                    ],
                                  ),
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
                                        categoriesState.getLimit(data['name']).toStringAsFixed(2) + " zł",
                                        style: TextStyle(fontSize: 40),
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
                                  value: categoriesState.getLimit(data['name']),
                                  onChanged: (newLimit) {
                                    categoriesState.changeLimit(data['name'], newLimit);
                                  },
                                  min: 0,
                                  max: 500,
                                  divisions: 500,
                                  label: categoriesState.getLimit(data['name']).toStringAsFixed(2)),
                              SizedBox(height: 5.0),
                              data['spent'] > categoriesState.getLimit(data['name'])
                                  ? Text(
                                      "PRZEKROCZONO LIMIT",
                                      style: TextStyle(
                                        letterSpacing: 2.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      "",
                                    ),
                            ],
                          ),
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
    );
  }
}
