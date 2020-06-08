import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/pages/Categories/categoryCard.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_state.dart';
import 'package:gdziemojhajsapp/pages/Categories/limit_transfer.dart';


import 'package:provider/provider.dart';


class Categories extends StatelessWidget {
  static String tag = "/categories";

  @override
  Widget build(BuildContext context) {
    final CategoriesState categoriesState =
        Provider.of<CategoriesState>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: ColorStyles.hexToColor("#F8F8FF"),
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(translate("categories")),
            ),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LimitTransfer.tag);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.compare_arrows,size: 27,),
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: SafeArea(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: categoriesState.categories
                              .map((category) =>
                                  CategoryCard(category: category))
                              .toList(),
                        )),
                  ),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
