import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/Controllers/category_controller.dart';
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
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text("Kategorie"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: FutureBuilder(
        future: CategoryController.getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            categoriesState.categories = snapshot.data;
            return ListView(
                children: categoriesState.categories
                    .map((category) => CategoryCard(category: category))
                    .toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
//      ListView(
//        children: categoriesState.categories.map((category) =>  CategoryCard(category: category)).toList(),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, LimitTransfer.tag);
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
