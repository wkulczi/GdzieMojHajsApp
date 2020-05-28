import 'package:combos/combos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:provider/provider.dart';

class LimitTransfer extends StatefulWidget {
  static String tag = "/limit_transfer";

  @override
  _LimitTransferState createState() => _LimitTransferState();
}

class _LimitTransferState extends State<LimitTransfer> {

  String _item1;
  String _item2;
  double val = 0;
  @override
  Widget build(BuildContext context) {

    final CategoriesState categoriesState = Provider.of<CategoriesState>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          centerTitle: true,
          title: Text(
            'Limit Transfer',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: SelectorCombo<String>(
                      getList: () {
                        return categoriesState.categories.map((e) => e.name).toList();
                      },
                      selected: _item1,
                      itemBuilder: (context, parameters, item, selected) =>
                          ListTile(
                              selected: selected, title: Text(item ?? '')),
                      childBuilder: (context, parameters, item) => ListTile(
                          enabled: true,
                          title: Text(item ?? 'Selector Combo')),
                      onSelectedChanged: (value) =>
                          setState(() => _item1 = value),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: SelectorCombo<String>(
                      getList: () {
                        return categoriesState.categories.map((e) => e.name).toList();
                      },
                      selected: _item2,
                      itemBuilder: (context, parameters, item, selected) =>
                          ListTile(
                              selected: selected, title: Text(item ?? '')),
                      childBuilder: (context, parameters, item) => ListTile(
                          enabled: true,
                          title: Text(item ?? 'Selector Combo')),
                      onSelectedChanged: (value) =>
                          setState(() => _item2 = value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      Text(
                        _item1 == null ? "0" : categoriesState.getLimit(_item1).toStringAsFixed(2) + " zł",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        _item2 == null ? "0" : categoriesState.getLimit(_item2).toStringAsFixed(2) + " zł",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                _item1 == null ? "WYBIERZ KATEGORIĘ": _item1,
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Slider(
                  value: categoriesState.getLimit(_item1) == null ?
                  val: categoriesState.getLimit(_item1).toDouble(),
                  onChanged: (newLimit) {
                    categoriesState.changeLimit(_item2, categoriesState.getLimit(_item2)-(newLimit-categoriesState.getLimit(_item1)));
                    categoriesState.changeLimit(_item1, newLimit);
                  },
                  min: 0,
                  max: _item1 == null? _item2 == null ? 0 : categoriesState.getLimit(_item2).toDouble() :
                  _item2 == null ? categoriesState.getLimit(_item1).toDouble() :
                  categoriesState.getLimit(_item1).toDouble() + categoriesState.getLimit(_item2).toDouble(),
                  divisions: 500
              ),
              SizedBox(height: 10.0),
              Text(
                _item2 == null ? "WYBIERZ KATEGORIĘ": _item2,
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Slider(
                  value:  categoriesState.getLimit(_item2) == null ?
                  val: categoriesState.getLimit(_item2).toDouble(),
                  onChanged: (newLimit) {
                    categoriesState.changeLimit(_item1, categoriesState.getLimit(_item1)-(newLimit-categoriesState.getLimit(_item2)));
                    categoriesState.changeLimit(_item2, newLimit);
                  },
                  min: 0,
                  max: _item1 == null? _item2 == null ? 0 : categoriesState.getLimit(_item2).toDouble() :
                  _item2 == null ? categoriesState.getLimit(_item1).toDouble() :
                  categoriesState.getLimit(_item1).toDouble() + categoriesState.getLimit(_item2).toDouble(),
                  divisions: 500,
              ),
            ],
          ),
        )
    );
  }
}
