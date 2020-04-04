import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

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
          ],
        ),
      )
    );
  }
}
