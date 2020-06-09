import 'package:combos/combos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
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
    final CategoriesState categoriesState =
        Provider.of<CategoriesState>(context);

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
                title: Text("Limit Transfer"),
              ),
              backgroundColor: Colors.transparent,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
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
                                _item1 == null ? translate('choose-category').toUpperCase(): _item1,
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Slider(
                                  value: categoriesState.getLimit(_item1) == null ?
                                  val: categoriesState.getLimit(_item1),
                                  onChanged: (newLimit) {
                                    categoriesState.changeLimit(_item2, categoriesState.getLimit(_item2)-(newLimit-categoriesState.getLimit(_item1)));
                                    categoriesState.changeLimit(_item1, newLimit);
                                  },
                                  min: 0,
                                  max: _item1 == null? _item2 == null ? 0 : categoriesState.getLimit(_item2):
                                  _item2 == null ? categoriesState.getLimit(_item1) :
                                  categoriesState.getLimit(_item1) + categoriesState.getLimit(_item2),
                                  divisions: 500
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                _item2 == null ? translate('choose-category').toUpperCase(): _item2,
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Slider(
                                value:  categoriesState.getLimit(_item2) == null ?
                                val: categoriesState.getLimit(_item2),
                                onChanged: (newLimit) {
                                  categoriesState.changeLimit(_item1, categoriesState.getLimit(_item1)-(newLimit-categoriesState.getLimit(_item2)));
                                  categoriesState.changeLimit(_item2, newLimit);
                                },
                                min: 0,
                                max: _item1 == null? _item2 == null ? 0 : categoriesState.getLimit(_item2) :
                                _item2 == null ? categoriesState.getLimit(_item1) :
                                categoriesState.getLimit(_item1) + categoriesState.getLimit(_item2),
                                divisions: 500,
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
    );
  }
}
